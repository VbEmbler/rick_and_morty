abstract class CharacterListEvent {}

final class InitEvent extends CharacterListEvent {}

final class FetchEvent extends CharacterListEvent {}

final class FavoriteToggledEvent extends CharacterListEvent {
  final int characterId;
  final bool isLiked;

  FavoriteToggledEvent(this.characterId, this.isLiked);
}
