import 'package:flutter_bloc/flutter_bloc.dart';

part 'favorites_character_event.dart';
part 'favorites_character_state.dart';

class FavoritesCharacterBloc
    extends Bloc<FavoritesCharacterEvent, FavoritesCharacterState> {
  Set<int> favoritesCharacter = {};
  //final SharedPrefer
  FavoritesCharacterBloc() : super(FavoritesCharacterEmptyState({})) {
    on<FavoritesCharacterInitEvent>(_initFavoritesCharacter);
    on<FavoritesCharacterUpdateEvent>(_updateFavoritesCharacter);
    on<FavoritesCharacterSaveEvent>(_saveFavoritesCharacter);
  }

  _initFavoritesCharacter(
    FavoritesCharacterInitEvent event,
    Emitter<FavoritesCharacterState> emit,
  ) async {
    favoritesCharacter = {1, 3, 16};
    emit(FavoritesCharacterLoadedState(favoritesCharacter));
  }

  _updateFavoritesCharacter(
    FavoritesCharacterUpdateEvent event,
    Emitter<FavoritesCharacterState> emit,
  ) async {
    if (event.favoritesCharacterIndex != null) {
      if (favoritesCharacter.contains(event.favoritesCharacterIndex)) {
        favoritesCharacter.remove(event.favoritesCharacterIndex);
      } else {
        favoritesCharacter.add(event.favoritesCharacterIndex!);
      }
    }
    emit(FavoritesCharacterLoadedState(favoritesCharacter));
  }

  _saveFavoritesCharacter(
    FavoritesCharacterSaveEvent event,
    Emitter<FavoritesCharacterState> emit,
  ) async {}
}
