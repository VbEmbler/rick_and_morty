import 'package:rick_and_morty/data/local_database/shared_preferences_utils.dart';

class CharacterSharedPrefRepository {
  final SharedPreferencesUtils characterFavoritesUtil;

  CharacterSharedPrefRepository({required this.characterFavoritesUtil});

  Future<Set<int>> getFavoritesCharacter() async {
    return await characterFavoritesUtil.getFavoritesCharacter();
  }

  Future saveFavoritesCharacter(Set<int> favoritesCharacter) async {
    await characterFavoritesUtil.saveFavoritesCharacter(favoritesCharacter);
  }
}
