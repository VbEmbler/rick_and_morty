import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/models/character_model.dart';
import 'package:rick_and_morty/res/project_colors.dart';
import 'package:rick_and_morty/res/project_icons.dart';
import 'package:rick_and_morty/res/project_text_styles.dart';
import 'package:rick_and_morty/screens/character_list/character_list_bloc.dart';
import 'package:rick_and_morty/screens/character_list/character_list_event.dart';
import 'package:rick_and_morty/screens/character_list/character_list_state.dart';
import 'package:rick_and_morty/screens/characters_details/character_details_bloc.dart';
import 'package:rick_and_morty/screens/characters_details/character_details_event.dart';
import 'package:rick_and_morty/utils/screen_init_status.dart';

class CharacterListScreen extends StatelessWidget {
  const CharacterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CharacterListBloc characterListBloc = context.read<CharacterListBloc>();
    characterListBloc.add(InitEvent());

    return Scaffold(
      body: CharacterListWidget(),
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
    CharacterListState characterListState = context.read<CharacterListBloc>().state;
    if (_isBottom && !characterListState.isFetching && !characterListState.isLastPage) {
      context.read<CharacterListBloc>().add(FetchEvent());
    }
  }

  bool get _isBottom {
    return _scrollController.position.extentAfter < 10;
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final double paddingTop = statusBarHeight + 20;
    return BlocBuilder<CharacterListBloc, CharacterListState>(
      builder: (context, state) {
        if (state.screenInitStatus == ScreenInitStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.screenInitStatus == ScreenInitStatus.success) {
          List<CharacterModel> characters = state.characterList!;
          return CharacterGridViewWidget(
            paddingTop: paddingTop,
            scrollController: _scrollController,
            characters: characters,
            state: state,
          );
        }
        return Placeholder();
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
  final List<CharacterModel> characters;
  final CharacterListState state;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: GridView.count(
            childAspectRatio: 0.7,
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 20, top: paddingTop, right: 20),
            mainAxisSpacing: 10,
            crossAxisSpacing: 20,
            controller: _scrollController,
            crossAxisCount: 2,
            children: List.generate(
              characters.length,
              (index) {
                return GestureDetector(
                  onTap: () {
                    context
                        .read<CharacterDetailsBloc>()
                        .add(CharacterDetailsInitEvent(characterId: characters[index].id!));
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
        if (state.isFetching)
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

  final List<CharacterModel> characters;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      color: ProjectColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Image.network(
                fit: BoxFit.cover,
                characters[index].image ?? '',
                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  );
                },
                errorBuilder: (context, exception, stackTrace) {
                  return Center(
                    child: Icon(
                      Icons.error,
                    ),
                  );
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
              '${characters[index].name}',
              style: ProjectTextStyles.bodyBold.copyWith(
                color: ProjectColors.nero,
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
  State<FavoritesCharacterWidget> createState() => _FavoritesCharacterWidgetState();
}

class _FavoritesCharacterWidgetState extends State<FavoritesCharacterWidget> {
  late bool? isLiked;
  late CharacterListBloc characterListBloc;
  bool isInit = false;

  @override
  void initState() {
    super.initState();

    characterListBloc = context.read<CharacterListBloc>();

    getIsFavorite().then((value) {
      setState(() {
        isLiked = value;
        isInit = true;
      });
    });
  }

  Future<bool?> getIsFavorite() async {
    return await characterListBloc.prefs.getFavoritesCharacter(widget.characterIndex);
  }

  Future saveFavoritesCharacter(int characterId, bool isLiked) async {
    characterListBloc.prefs.saveFavoritesCharacter(characterId, isLiked);
  }

  @override
  Widget build(BuildContext context) {
    if (isInit) {
      return InkWell(
        onTap: () {
          if (isLiked == null) {
            setState(() {
              isLiked = true;
            });
          } else {
            setState(() {
              isLiked = !isLiked!;
            });
          }
          //characterListBloc.add(CharacterListSaveFavoriteEvent(widget.characterIndex, isFavorite!));
          saveFavoritesCharacter(widget.characterIndex, isLiked!);
        },
        child: Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: ProjectColors.white,
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            fit: BoxFit.fill,
            isLiked == null ? ProjectIcons.unliked : (isLiked! ? ProjectIcons.liked : ProjectIcons.unliked),
            height: 20,
            width: 20,
          ),
        ),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
