import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/characters/src/local_database/character_favorites_util.dart';

part 'favorites_character_event.dart';
part 'favorites_character_state.dart';

class FavoritesCharacterBloc
    extends Bloc<FavoritesCharacterEvent, FavoritesCharacterState> {
  Set<int> favoritesCharacter = {};
  final CharacterFavoritesUtil characterFavoritesUtil;
  FavoritesCharacterBloc({required this.characterFavoritesUtil})
      : super(FavoritesCharacterEmptyState({})) {
    on<FavoritesCharacterInitEvent>(_initFavoritesCharacter);
    on<FavoritesCharacterUpdateEvent>(_updateFavoritesCharacter);
    on<FavoritesCharacterSaveEvent>(_saveFavoritesCharacter);
  }

  _initFavoritesCharacter(
    FavoritesCharacterInitEvent event,
    Emitter<FavoritesCharacterState> emit,
  ) async {
    favoritesCharacter = await characterFavoritesUtil.getFavoritesCharacter();
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
  ) async {
    await characterFavoritesUtil.saveFavoritesCharacter(favoritesCharacter);
  }
}
