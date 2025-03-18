import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/api_statuses/api_failure.dart';
import 'package:rick_and_morty/core/api_statuses/api_success.dart';
import 'package:rick_and_morty/core/platform/network_failure.dart';
import 'package:rick_and_morty/core/states.dart';
import 'package:rick_and_morty/features/characters/constants.dart';
import 'package:rick_and_morty/features/characters/models/character_list_model.dart';
import 'package:rick_and_morty/features/characters/src/repositories/characters_remote_repository.dart';

part 'character_list_event.dart';
part 'character_list_state.dart';

class CharacterListBloc extends Bloc<CharacterListEvent, CharacterListState> {
  CharacterListModel characterListModel = CharacterListModel();
  final CharactersRemoteRepository charactersRemoteRepository;

  CharacterListBloc({required this.charactersRemoteRepository})
      : super(CharacterListEmptyState()) {
    on<CharacterListInitEvent>(_initCharacterList);
    on<CharacterListFetchEvent>(_fetchCharacterList);
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
}
