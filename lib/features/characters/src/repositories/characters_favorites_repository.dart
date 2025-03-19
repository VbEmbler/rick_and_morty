import 'package:rick_and_morty/features/characters/src/local_database/character_favorites_util.dart';

class CharacterFavoritesRepository {
  final CharacterFavoritesUtil characterFavoritesUtil;

  CharacterFavoritesRepository({required this.characterFavoritesUtil});

  Future<Set<int>> getFavoritesCharacter() async {
    return await characterFavoritesUtil.getFavoritesCharacter();
  }

  Future saveFavoritesCharacter(Set<int> favoritesCharacter) async {
    await characterFavoritesUtil.saveFavoritesCharacter(favoritesCharacter);
  }
}
