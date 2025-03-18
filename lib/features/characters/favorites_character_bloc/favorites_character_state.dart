part of 'favorites_character_bloc.dart';

abstract class FavoritesCharacterState {
  final Set<int> favorites;

  FavoritesCharacterState(this.favorites);
}

final class FavoritesCharacterInitState extends FavoritesCharacterState {
  FavoritesCharacterInitState(super.favorites);
}

final class FavoritesCharacterEmptyState extends FavoritesCharacterState {
  FavoritesCharacterEmptyState(super.favorites);
}

final class FavoritesCharacterLoadedState extends FavoritesCharacterState {
  FavoritesCharacterLoadedState(super.favorites);
}
