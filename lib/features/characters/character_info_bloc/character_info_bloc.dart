import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/api_statuses/api_failure.dart';
import 'package:rick_and_morty/core/api_statuses/api_success.dart';
import 'package:rick_and_morty/core/platform/network_failure.dart';
import 'package:rick_and_morty/features/characters/src/repositories/characters_remote_repository.dart';
import 'package:rick_and_morty/core/states.dart';
import 'package:rick_and_morty/features/characters/models/character_model.dart';

part 'character_info_event.dart';
part 'character_info_state.dart';

class CharacterInfoBloc extends Bloc<CharacterInfoEvent, CharacterInfoState> {
  final CharactersRemoteRepository charactersRemoteRepository;

  CharacterInfoBloc({required this.charactersRemoteRepository})
      : super(CharacterInfoEmptyState()) {
    on<CharacterInfoInitEvent>(_initCharacterInfo);
  }

  _initCharacterInfo(
      CharacterInfoInitEvent event, Emitter<CharacterInfoState> emit) async {
    emit(CharacterInfoInitState());
    try {
      ApiSuccess response = await charactersRemoteRepository.getCharacter(
          characterId: event.characterId) as ApiSuccess;
      CharacterModel characterModel = response.response as CharacterModel;
      emit(CharacterInfoLoadedState(characterModel: characterModel));
    } on ApiFailure catch (e) {
      emit(
        CharacterInfoErrorState(
          errorMessage: e.errorResponse,
          errorCode: e.code,
        ),
      );
    } on NetworkFailure catch (e) {
      emit(CharacterInfoErrorState(errorMessage: e.error));
    } catch (e) {
      emit(CharacterInfoErrorState(errorMessage: e.toString()));
    }
  }
}
