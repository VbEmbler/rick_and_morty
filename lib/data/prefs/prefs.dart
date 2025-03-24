import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  Future<bool?> getFavoritesCharacter(int characterId) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getBool('favorites_$characterId');
  }

  Future saveFavoritesCharacter(int characterId, bool isLiked) async {
    final sharedPrefs = await SharedPreferences.getInstance();
    sharedPrefs.setBool('favorites_$characterId', isLiked);
  }
}
