import 'package:shared_preferences/shared_preferences.dart';

const String favoritesKey = 'favorites_';

class Prefs {
  Future<Map<String, bool>> getFavoritesCharacter() async {
    Map<String, bool> likedCharacters = {};
    final sharedPrefs = await SharedPreferences.getInstance();
    final keys = sharedPrefs.getKeys();
    for (String key in keys) {
      if (key.contains(favoritesKey) && sharedPrefs.get(key) is bool) {
        likedCharacters[key.substring(favoritesKey.length)] = sharedPrefs.get(key) as bool;
      }
    }
    return likedCharacters;
  }

  Future saveFavoritesCharacter(int characterId, bool isLiked) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setBool('$favoritesKey$characterId', isLiked);
  }
}
