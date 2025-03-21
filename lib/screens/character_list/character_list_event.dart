part of 'character_list_bloc.dart';

abstract class CharacterListEvent {}

final class CharacterListInitEvent extends CharacterListEvent {}

final class CharacterListFetchEvent extends CharacterListEvent {}

final class CharacterListGetFavoritesEvent extends CharacterListEvent {}

final class CharacterListUpdateFavoritesEvent extends CharacterListEvent {
  int? favoritesCharacterIndex;

  CharacterListUpdateFavoritesEvent(this.favoritesCharacterIndex);
}

final class CharacterListSaveFavoritesCharacterEvent
    extends CharacterListEvent {}
