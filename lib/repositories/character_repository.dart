import 'package:rick_and_morty/data/api/characters_api.dart';

import 'package:rick_and_morty/data/network/api_success.dart';
import 'package:rick_and_morty/data/prefs/prefs.dart';

class CharacterRepository {
  final CharactersApi _charactersApi;
  final Prefs _prefs;

  CharacterRepository({
    required CharactersApi charactersApi,
    required Prefs prefs,
  })  : _charactersApi = charactersApi,
        _prefs = prefs;

  Future<Object> getCharacterList(int? page) async {
    try {
      ApiSuccess response =
          await _charactersApi.getCharacterList(page) as ApiSuccess;
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Object> getCharacter({required int characterId}) async {
    try {
      ApiSuccess response = await _charactersApi.getCharacter(
          characterId: characterId) as ApiSuccess;
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool?> getFavoritesCharacter(int characterId) async {
    return await _prefs.getFavoritesCharacter(characterId);
  }

  Future saveFavoritesCharacter(int characterId, bool isLiked) async {
    await _prefs.saveFavoritesCharacter(characterId, isLiked);
  }
}
