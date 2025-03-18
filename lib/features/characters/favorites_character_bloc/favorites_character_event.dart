part of 'favorites_character_bloc.dart';

abstract class FavoritesCharacterEvent {}

class FavoritesCharacterInitEvent extends FavoritesCharacterEvent {}

class FavoritesCharacterUpdateEvent extends FavoritesCharacterEvent {
  int? favoritesCharacterIndex;

  FavoritesCharacterUpdateEvent(this.favoritesCharacterIndex);
}

class FavoritesCharacterSaveEvent extends FavoritesCharacterEvent {}
