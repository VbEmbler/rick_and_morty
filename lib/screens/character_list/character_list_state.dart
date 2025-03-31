import 'package:rick_and_morty/models/character_model.dart';
import 'package:rick_and_morty/utils/screen_init_status.dart';

class CharacterListState {
  final List<CharacterModel> characterList;
  final int nextPage;
  final bool isFetching;
  final ScreenInitStatus screenInitStatus;
  final bool isLastPage;
  final Map<String, bool> likedCharacter;

  CharacterListState({
    this.characterList = const [],
    this.nextPage = 0,
    this.isFetching = false,
    this.screenInitStatus = ScreenInitStatus.loading,
    this.isLastPage = false,
    this.likedCharacter = const {},
  });

  CharacterListState copyWith({
    List<CharacterModel>? characterList,
    int? nextPage,
    bool? isFetching,
    ScreenInitStatus? screenInitStatus,
    bool? isLastPage,
    Map<String, bool>? likedCharacter,
  }) {
    return CharacterListState(
      characterList: characterList ?? this.characterList,
      nextPage: nextPage ?? this.nextPage,
      isFetching: isFetching ?? this.isFetching,
      screenInitStatus: screenInitStatus ?? this.screenInitStatus,
      isLastPage: isLastPage ?? this.isLastPage,
      likedCharacter: likedCharacter ?? this.likedCharacter,
    );
  }
}
