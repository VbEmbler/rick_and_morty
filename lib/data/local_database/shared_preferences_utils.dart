import 'package:rick_and_morty/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  static Future<SharedPreferences> get _getInstance async =>
      prefInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? prefInstance;

  static Future init() async {
    prefInstance = await _getInstance;
  }

  Future<Set<int>> getFavoritesCharacter() async {
    if (prefInstance == null) init();
    List<String>? favoritesCharacterString =
        prefInstance!.getStringList(Constants.sharedPrefFavoritesCharacterKey);
    Set<int> favoritesCharacter = {};
    if (favoritesCharacterString != null) {
      favoritesCharacter =
          favoritesCharacterString.map((i) => int.parse(i)).toSet();
    }
    return favoritesCharacter;
  }

  Future saveFavoritesCharacter(Set<int> favoritesCharacter) async {
    if (prefInstance == null) init();
    List<String> favoritesCharacterString =
        favoritesCharacter.map((i) => i.toString()).toList();
    await prefInstance!.setStringList(
        Constants.sharedPrefFavoritesCharacterKey, favoritesCharacterString);
  }
}
