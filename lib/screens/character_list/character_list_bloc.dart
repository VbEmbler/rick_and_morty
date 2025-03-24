import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/data/network/api_failure.dart';
import 'package:rick_and_morty/data/network/api_success.dart';
import 'package:rick_and_morty/data/network/network_failure.dart';
import 'package:rick_and_morty/data/network/states.dart';
import 'package:rick_and_morty/data/prefs/prefs.dart';
import 'package:rick_and_morty/models/character_list_model.dart';
import 'package:rick_and_morty/repositories/character_repository.dart';

part 'character_list_event.dart';
part 'character_list_state.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  CharacterListModel characterListModel = CharacterListModel();

  final Prefs prefs;
  final CharacterRepository _characterRepository;

  CharacterListBloc(
      {required CharacterRepository characterRepository, required this.prefs})
      : _characterRepository = characterRepository,
        super(CharacterListEmptyState()) {
    on<CharacterListInitEvent>(_initCharacterList);
    on<CharacterListFetchEvent>(_fetchCharacterList);
    on<CharacterListGetFavoritesEvent>(_getFavoritesCharacter);
    on<CharacterListSaveFavoriteEvent>(_saveFavoritesCharacter);
  }

  _initCharacterList(
    CharacterListInitEvent event,
    Emitter<CharacterListState> emit,
  ) async {
    emit(CharacterListInitState());
    try {
      ApiSuccess response =
          await _characterRepository.getCharacterList(null) as ApiSuccess;
      characterListModel = response.response as CharacterListModel;
      emit(CharacterListLoadedState(
          characterListModel: characterListModel, isFetch: false));
    } on ApiFailure catch (e) {
      emit(
        CharacterListErrorState(
          errorCode: e.code,
          errorMessage: e.errorResponse,
        ),
      );
    } on NetworkFailure catch (e) {
      emit(CharacterListErrorState(errorMessage: e.error));
    } catch (e) {
      emit(CharacterListErrorState(errorMessage: e.toString()));
    }
  }

  _fetchCharacterList(
    CharacterListFetchEvent event,
    Emitter<CharacterListState> emit,
  ) async {
    emit(CharacterListLoadedState(
        characterListModel: characterListModel, isFetch: true));
    try {
      if (characterListModel.info != null &&
          characterListModel.info!.next != null) {
        String pageNumberString =
            characterListModel.info!.next!.replaceAll(RegExp(r'[^0-9]'), '');
        ApiSuccess response = await _characterRepository
            .getCharacterList(int.parse(pageNumberString)) as ApiSuccess;

        CharacterListModel characterListModelTemp =
            response.response as CharacterListModel;
        characterListModel.info = characterListModelTemp.info;
        characterListModel.characterList
            ?.addAll(characterListModelTemp.characterList!);
        emit(CharacterListLoadedState(
            characterListModel: characterListModel, isFetch: false));
      }
      //}
    } on ApiFailure catch (e) {
      emit(
        CharacterListErrorState(
          errorCode: e.code,
          errorMessage: e.errorResponse,
        ),
      );
    } on NetworkFailure catch (e) {
      emit(CharacterListErrorState(errorMessage: e.error));
    } catch (e) {
      emit(CharacterListErrorState(errorMessage: e.toString()));
    }
  }

  _getFavoritesCharacter(
    CharacterListGetFavoritesEvent event,
    Emitter<CharacterListState> emit,
  ) async {
    //favoritesCharacter = await prefs.getFavoritesCharacter();
  }

  _saveFavoritesCharacter(
    CharacterListSaveFavoriteEvent event,
    Emitter<CharacterListState> emit,
  ) async {
    await prefs.saveFavoritesCharacter(event.characterId, event.isFavorite);
  }
}
