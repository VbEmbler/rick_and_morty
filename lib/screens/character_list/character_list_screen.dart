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
import 'package:rick_and_morty/sl.dart';
import 'package:rick_and_morty/utils/screen_init_status.dart';

class CharacterListScreen extends StatelessWidget {
  const CharacterListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    sl<CharacterListBloc>().add(InitEvent());

    return Scaffold(
      body: CharacterListWidget(),
    );
  }
}

class CharacterListWidget extends StatelessWidget {
  const CharacterListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterListBloc, CharacterListState>(
      builder: (context, state) {
        if (state.screenInitStatus == ScreenInitStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.screenInitStatus == ScreenInitStatus.success) {
          return CharacterGridViewWidget(
            state: state,
          );
        }
        return Placeholder();
      },
    );
  }
}

class CharacterGridViewWidget extends StatefulWidget {
  const CharacterGridViewWidget({
    super.key,
    required this.state,
  });

  final CharacterListState state;

  @override
  State<CharacterGridViewWidget> createState() => _CharacterGridViewWidgetState();
}

class _CharacterGridViewWidgetState extends State<CharacterGridViewWidget> {
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
    CharacterListState characterListState = sl<CharacterListBloc>().state;
    if (_isBottom && !characterListState.isFetching && !characterListState.isLastPage) {
      sl<CharacterListBloc>().add(FetchEvent());
    }
  }

  bool get _isBottom {
    return _scrollController.position.extentAfter < 10;
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    final double paddingTop = statusBarHeight + 20;
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
              widget.state.characterList.length,
              (index) {
                return GestureDetector(
                  onTap: () {},
                  child: CharacterCardWidget(
                    character: widget.state.characterList[index],
                  ),
                );
              },
            ),
          ),
        ),
        if (widget.state.isFetching)
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
    required this.character,
  });

  final CharacterModel character;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        sl<CharacterDetailsBloc>().add(CharacterDetailsInitEvent(characterId: character.id));
        context.go('/character_info');
      },
      child: Card(
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
                  character.image ?? '',
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
                    characterId: character.id,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, top: 5.0, right: 10.0),
              child: Text(
                '${character.name}',
                style: ProjectTextStyles.bodyBold.copyWith(
                  color: ProjectColors.nero,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FavoritesCharacterWidget extends StatelessWidget {
  final int characterId;

  const FavoritesCharacterWidget({
    super.key,
    required this.characterId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharacterListBloc, CharacterListState>(
      buildWhen: (previous, current) {
        return previous.likedCharacter != current.likedCharacter;
      },
      builder: (context, state) {
        bool? isLiked = state.likedCharacter[characterId.toString()];
        return InkWell(
          onTap: () {
            if (isLiked == null) {
              isLiked = true;
            } else {
              isLiked = !isLiked!;
            }
            sl<CharacterListBloc>().add(FavoriteToggledEvent(characterId, isLiked!));
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
              isLiked == null ? ProjectIcons.unliked : (isLiked ? ProjectIcons.liked : ProjectIcons.unliked),
              height: 20,
              width: 20,
            ),
          ),
        );
      },
    );
  }
}
