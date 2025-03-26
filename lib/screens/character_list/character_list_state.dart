import 'package:rick_and_morty/models/character_model.dart';
import 'package:rick_and_morty/utils/screen_init_status.dart';

class CharacterListState {
  final List<CharacterModel>? characterList;
  final int nextPage;
  final bool isFetching;
  final ScreenInitStatus screenInitStatus;
  final bool isLastPage;

  CharacterListState({
    this.characterList,
    this.nextPage = 0,
    this.isFetching = false,
    this.screenInitStatus = ScreenInitStatus.loading,
    this.isLastPage = false,
  });

  CharacterListState copyWith({
    List<CharacterModel>? characterList,
    int? nextPage,
    bool? isFetching,
    ScreenInitStatus? screenInitStatus,
    bool? isLastPage,
  }) {
    return CharacterListState(
      characterList: characterList ?? this.characterList,
      nextPage: nextPage ?? this.nextPage,
      isFetching: isFetching ?? this.isFetching,
      screenInitStatus: screenInitStatus ?? this.screenInitStatus,
      isLastPage: isLastPage ?? this.isLastPage,
    );
  }
}
