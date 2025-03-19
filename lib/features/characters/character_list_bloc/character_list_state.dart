part of 'character_list_bloc.dart';

abstract class CharacterListState {}

final class CharacterListEmptyState extends CharacterListState {}

final class CharacterListInitState extends CharacterListState {}

final class CharacterListFetchState extends CharacterListState {}

final class CharacterListLoadedState extends CharacterListState {
  bool isFetch;
  CharacterListModel characterListModel;

  CharacterListLoadedState(
      {required this.characterListModel, required this.isFetch});
}

final class CharacterListErrorState extends CharacterListState
    implements ErrorState {
  @override
  int? errorCode;
  @override
  String? errorMessage;
  CharacterListErrorState({this.errorCode, this.errorMessage});
}
