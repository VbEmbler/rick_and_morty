part of 'character_list_bloc.dart';

abstract class CharacterListEvent {}

final class CharacterListInitEvent extends CharacterListEvent {}

final class CharacterListFetchEvent extends CharacterListEvent {}

final class CharacterListGetFavoriteStatusEvent extends CharacterListEvent {
  final int characterId;
  CharacterListGetFavoriteStatusEvent(this.characterId);
}

final class CharacterListToggleFavoriteEvent extends CharacterListEvent {
  final int characterId;
  final bool isFavorite;
  CharacterListToggleFavoriteEvent(this.characterId, this.isFavorite);
}

class CharacterListGetFavoritesEvent extends CharacterListEvent {
  final int characterId;
  CharacterListGetFavoritesEvent(this.characterId);
}

class CharacterListSaveFavoriteEvent extends CharacterListEvent {
  final int characterId;
  final bool isFavorite;
  CharacterListSaveFavoriteEvent(this.characterId, this.isFavorite);
}
