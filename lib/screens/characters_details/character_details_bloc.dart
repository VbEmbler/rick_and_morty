import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/data/network/api_failure.dart';
import 'package:rick_and_morty/data/network/api_success.dart';
import 'package:rick_and_morty/data/network/network_failure.dart';
import 'package:rick_and_morty/data/network/states.dart';
import 'package:rick_and_morty/models/character_model.dart';
import 'package:rick_and_morty/repositories/character_repository.dart';

part 'character_details_event.dart';
part 'character_details_state.dart';

class CharacterDetailsBloc
    extends Bloc<CharacterDetailsEvent, CharacterDetailsState> {
  final CharacterRepository characterRepository;

  CharacterDetailsBloc({required this.characterRepository})
      : super(CharacterDetailsEmptyState()) {
    on<CharacterInfoInitEvent>(_initCharacterInfo);
  }

  _initCharacterInfo(
      CharacterInfoInitEvent event, Emitter<CharacterDetailsState> emit) async {
    emit(CharacterDetailsInitState());
    try {
      ApiSuccess response = await characterRepository.getCharacter(
          characterId: event.characterId) as ApiSuccess;
      CharacterModel characterModel = response.response as CharacterModel;
      emit(CharacterDetailsLoadedState(characterModel: characterModel));
    } on ApiFailure catch (e) {
      emit(
        CharacterDetailsErrorState(
          errorMessage: e.errorResponse,
          errorCode: e.code,
        ),
      );
    } on NetworkFailure catch (e) {
      emit(CharacterDetailsErrorState(errorMessage: e.error));
    } catch (e) {
      emit(CharacterDetailsErrorState(errorMessage: e.toString()));
    }
  }
}
