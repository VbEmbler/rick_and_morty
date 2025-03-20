part of 'character_details_bloc.dart';

abstract class CharacterDetailsState {}

final class CharacterDetailsEmptyState extends CharacterDetailsState {}

final class CharacterDetailsInitState extends CharacterDetailsState {}

final class CharacterDetailsLoadedState extends CharacterDetailsState {
  CharacterModel characterModel;
  CharacterDetailsLoadedState({required this.characterModel});
}

final class CharacterDetailsErrorState extends CharacterDetailsState
    implements ErrorState {
  @override
  int? errorCode;
  @override
  String? errorMessage;
  CharacterDetailsErrorState({this.errorCode, this.errorMessage});
}
