import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/api_statuses/api_failure.dart';
import 'package:rick_and_morty/core/api_statuses/api_success.dart';
import 'package:rick_and_morty/core/platform/network_failure.dart';
import 'package:rick_and_morty/core/states.dart';
import 'package:rick_and_morty/features/characters/constants.dart';
import 'package:rick_and_morty/features/characters/data/local_database/shared_preferences_utils.dart';
import 'package:rick_and_morty/features/characters/models/character_list_model.dart';
import 'package:rick_and_morty/features/characters/repositories/characters_remote_repository.dart';

part 'character_list_event.dart';
part 'character_list_state.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  CharacterListModel characterListModel = CharacterListModel();
  Set<int> favoritesCharacter = {};

  final SharedPreferencesUtils sharedPreferencesUtil;
  final CharactersRemoteRepository charactersRemoteRepository;

  CharacterListBloc(
      {required this.charactersRemoteRepository,
      required this.sharedPreferencesUtil})
      : super(CharacterListEmptyState()) {
    on<CharacterListInitEvent>(_initCharacterList);
    on<CharacterListFetchEvent>(_fetchCharacterList);
    on<CharacterListGetFavoritesEvent>(_getFavoritesCharacter);
    on<CharacterListUpdateFavoritesEvent>(_updateFavoritesCharacter);
    on<CharacterListSaveFavoritesCharacterEvent>(_saveFavoritesCharacter);
  }

  _initCharacterList(
    CharacterListInitEvent event,
    Emitter<CharacterListState> emit,
  ) async {
    emit(CharacterListInitState());
    try {
      ApiSuccess response = await charactersRemoteRepository.getCharacterList(
          '${Constants.baseURL}${Constants.characterEndpoint}') as ApiSuccess;
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
        ApiSuccess response = await charactersRemoteRepository
            .getCharacterList(characterListModel.info!.next!) as ApiSuccess;
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
    favoritesCharacter = await sharedPreferencesUtil.getFavoritesCharacter();
  }

  _updateFavoritesCharacter(
    CharacterListUpdateFavoritesEvent event,
    Emitter<CharacterListState> emit,
  ) async {
    if (event.favoritesCharacterIndex != null) {
      if (favoritesCharacter.contains(event.favoritesCharacterIndex)) {
        favoritesCharacter.remove(event.favoritesCharacterIndex);
      } else {
        favoritesCharacter.add(event.favoritesCharacterIndex!);
      }
    }
  }

  _saveFavoritesCharacter(
    CharacterListSaveFavoritesCharacterEvent event,
    Emitter<CharacterListState> emit,
  ) async {
    await sharedPreferencesUtil.saveFavoritesCharacter(favoritesCharacter);
  }
}
