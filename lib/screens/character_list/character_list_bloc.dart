import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:rick_and_morty/data/prefs/prefs.dart';
import 'package:rick_and_morty/models/character_list_model.dart';
import 'package:rick_and_morty/models/character_model.dart';
import 'package:rick_and_morty/repositories/character_repository.dart';
import 'package:rick_and_morty/screens/character_list/character_list_event.dart';
import 'package:rick_and_morty/screens/character_list/character_list_state.dart';
import 'package:rick_and_morty/utils/screen_init_status.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  final Prefs prefs;
  final CharacterRepository _characterRepository;

  CharacterListBloc({required CharacterRepository characterRepository, required this.prefs})
      : _characterRepository = characterRepository,
        super(CharacterListState()) {
    on<InitEvent>(_initCharacterList);
    on<FetchEvent>(_fetchCharacterList);
  }

  _initCharacterList(
    InitEvent event,
    Emitter<CharacterListState> emit,
  ) async {
    CharacterListModel characterListModel = await _characterRepository.getCharacterList(null);
    int? nextPageId;
    if (characterListModel.info?.next != null) {
      nextPageId = getNextPageId(characterListModel.info!.next!);
    }

    emit(
      CharacterListState().copyWith(
        characterList: characterListModel.characterList,
        screenInitStatus: ScreenInitStatus.success,
        nextPage: nextPageId,
      ),
    );
  }

  _fetchCharacterList(
    FetchEvent event,
    Emitter<CharacterListState> emit,
  ) async {
    emit(state.copyWith(
      isFetching: true,
    ));

    CharacterListModel characterListModel = await _characterRepository.getCharacterList(state.nextPage);
    int? nextPageId;
    if (characterListModel.info?.next != null) {
      nextPageId = getNextPageId(characterListModel.info!.next!);
    }

    List<CharacterModel> charactersTemp = state.characterList!;
    charactersTemp.addAll(characterListModel.characterList!);
    emit(
      state.copyWith(
        characterList: charactersTemp,
        nextPage: nextPageId,
        isFetching: false,
        isLastPage: nextPageId == null ? true : false,
      ),
    );
  }

  int? getNextPageId(String nextUrl) {
    return int.parse(nextUrl.replaceAll(RegExp(r'[^0-9]'), ''));
  }
}
