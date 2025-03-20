import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/core/voids/voids.dart';
import 'package:rick_and_morty/features/characters/screens/characters_details/character_details_bloc.dart';
import 'package:rick_and_morty/features/characters/models/character_list_model.dart';
import 'package:rick_and_morty/features/characters/screens/character_list/character_list_bloc.dart';
import 'package:rick_and_morty/features/characters/widgets/error_getting_data_widget.dart';

class CharacterListScreen extends StatelessWidget {
  const CharacterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double snackBarHeight = 40.0;
    final double snackBarPosition = screenHeight / 2 - snackBarHeight;

    CharacterListBloc characterListBloc = context.read<CharacterListBloc>();
    characterListBloc.add(CharacterListInitEvent());

    return Scaffold(
      body: BlocListener<CharacterListBloc, CharacterListState>(
        listener: (context, state) {
          if (state is CharacterListErrorState) {
            showSnackBar(state, snackBarPosition, context);
          }
        },
        child: CharacterListWidget(),
      ),
    );
  }
}

class CharacterListWidget extends StatefulWidget {
  const CharacterListWidget({super.key});

  @override
  State<CharacterListWidget> createState() => _CharacterListWidgetState();
}

class _CharacterListWidgetState extends State<CharacterListWidget> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    CharacterListState characterListState =
        context.read<CharacterListBloc>().state;
    if (characterListState is CharacterListLoadedState) {
      if (_isBottom && !characterListState.isFetch) {
        context.read<CharacterListBloc>().add(CharacterListFetchEvent());
      }
    }
  }

  bool get _isBottom {
    return _scrollController.position.extentAfter < 100;
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final double paddingTop = statusBarHeight + 20;
    return BlocBuilder<CharacterListBloc, CharacterListState>(
      builder: (context, state) {
        if (state is CharacterListInitState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is CharacterListLoadedState) {
          CharacterListModel characters = state.characterListModel;
          return CharacterGridViewWidget(
            paddingTop: paddingTop,
            scrollController: _scrollController,
            characters: characters,
            state: state,
          );
        } else if (state is CharacterListErrorState) {
          return const ErrorGettingDataWidget();
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class CharacterGridViewWidget extends StatelessWidget {
  const CharacterGridViewWidget({
    super.key,
    required this.paddingTop,
    required ScrollController scrollController,
    required this.characters,
    required this.state,
  }) : _scrollController = scrollController;

  final double paddingTop;
  final ScrollController _scrollController;
  final CharacterListModel characters;
  final CharacterListLoadedState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.count(
            childAspectRatio: 0.75,
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 20, top: paddingTop, right: 20),
            mainAxisSpacing: 10,
            crossAxisSpacing: 20,
            controller: _scrollController,
            crossAxisCount: 2,
            children: List.generate(
              characters.characterList!.length,
              (index) {
                return GestureDetector(
                  onTap: () {
                    context.read<CharacterDetailsBloc>().add(
                        CharacterInfoInitEvent(
                            characterId: characters.characterList![index].id!));
                    context.go('/character_info');
                  },
                  child: CharacterCardWidget(
                    characters: characters,
                    index: index,
                  ),
                );
              },
            ),
          ),
        ),
        if (state.isFetch)
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 40),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}

class CharacterCardWidget extends StatelessWidget {
  const CharacterCardWidget({
    super.key,
    required this.characters,
    required this.index,
  });

  final CharacterListModel characters;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                fit: BoxFit.cover,
                characters.characterList![index].image ?? '',
                loadingBuilder: (BuildContext context, Widget child,
                    ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, exception, stackTrace) {
                  return Placeholder();
                },
              ),
              Positioned(
                right: 10,
                top: 10,
                child: FavoritesCharacterWidget(
                  characterIndex: index,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
            child: Text(
              '${characters.characterList![index].name}',
              style: TextStyle(
                fontFamily: 'Lato',
                fontWeight: FontWeight.w700,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FavoritesCharacterWidget extends StatefulWidget {
  final int characterIndex;

  const FavoritesCharacterWidget({
    super.key,
    required this.characterIndex,
  });

  @override
  State<FavoritesCharacterWidget> createState() =>
      _FavoritesCharacterWidgetState();
}

class _FavoritesCharacterWidgetState extends State<FavoritesCharacterWidget> {
  @override
  Widget build(BuildContext context) {
    final bool isFavorite = context
        .read<CharacterListBloc>()
        .favoritesCharacter
        .contains(widget.characterIndex);
    return InkWell(
      onTap: () {
        context
            .read<CharacterListBloc>()
            .add(CharacterListUpdateFavoritesEvent(widget.characterIndex));
        context
            .read<CharacterListBloc>()
            .add(CharacterListSaveFavoritesCharacterEvent());
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          fit: BoxFit.fill,
          isFavorite ? 'assets/liked.svg' : 'assets/unliked.svg',
          height: 20,
          width: 20,
        ),
      ),
    );
  }
}
