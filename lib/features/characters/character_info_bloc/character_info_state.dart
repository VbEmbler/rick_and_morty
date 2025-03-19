part of 'character_info_bloc.dart';

abstract class CharacterInfoState {}

final class CharacterInfoEmptyState extends CharacterInfoState {}

final class CharacterInfoInitState extends CharacterInfoState {}

final class CharacterInfoLoadedState extends CharacterInfoState {
  CharacterModel characterModel;
  CharacterInfoLoadedState({required this.characterModel});
}

final class CharacterInfoErrorState extends CharacterInfoState
    implements ErrorState {
  @override
  int? errorCode;
  @override
  String? errorMessage;
  CharacterInfoErrorState({this.errorCode, this.errorMessage});
}
