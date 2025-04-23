import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:rick_and_morty/models/character_model.dart';
import 'package:rick_and_morty/repositories/character_repository.dart';
import 'package:rick_and_morty/screens/characters_details/character_details_event.dart';
import 'package:rick_and_morty/screens/characters_details/character_details_state.dart';
import 'package:rick_and_morty/utils/screen_init_status.dart';

@injectable
class CharacterDetailsBloc extends Bloc<CharacterDetailsEvent, CharacterDetailsState> {
  final CharacterRepository characterRepository;

  CharacterDetailsBloc({required this.characterRepository}) : super(CharacterDetailsState()) {
    on<CharacterDetailsInitEvent>(_initCharacterInfo);
  }

  _initCharacterInfo(CharacterDetailsInitEvent event, Emitter<CharacterDetailsState> emit) async {
    CharacterModel character = await characterRepository.getCharacter(characterId: event.characterId);

    emit(state.copyWith(character: character, screenInitStatus: ScreenInitStatus.success));
  }
}
