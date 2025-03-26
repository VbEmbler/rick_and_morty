import 'package:rick_and_morty/models/character_model.dart';
import 'package:rick_and_morty/utils/screen_init_status.dart';

class CharacterDetailsState {
  final CharacterModel? character;
  final ScreenInitStatus screenInitStatus;

  CharacterDetailsState({
    this.character,
    this.screenInitStatus = ScreenInitStatus.loading,
  });

  CharacterDetailsState copyWith({
    CharacterModel? character,
    ScreenInitStatus? screenInitStatus,
  }) {
    return CharacterDetailsState(
      character: character ?? this.character,
      screenInitStatus: screenInitStatus ?? this.screenInitStatus,
    );
  }
}
