import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/features/characters/character_info_bloc/character_info_bloc.dart';
import 'package:rick_and_morty/features/characters/character_list_bloc/character_list_bloc.dart';
import 'package:rick_and_morty/features/characters/models/character_list_model.dart';
import 'package:rick_and_morty/features/characters/widgets/character_card_widget.dart';

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
                    context.read<CharacterInfoBloc>().add(
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
