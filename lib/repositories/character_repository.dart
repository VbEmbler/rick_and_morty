import 'package:rick_and_morty/data/api/characters_api.dart';

import 'package:rick_and_morty/data/prefs/prefs.dart';
import 'package:rick_and_morty/models/character_list_model.dart';
import 'package:rick_and_morty/models/character_model.dart';

class CharacterRepository {
  final CharactersApi _charactersApi;
  final Prefs _prefs;

  CharacterRepository({
    required CharactersApi charactersApi,
    required Prefs prefs,
  })  : _charactersApi = charactersApi,
        _prefs = prefs;

  Future<CharacterListModel> getCharacterList(int? page) async {
    CharacterListModel response = await _charactersApi.getCharacterList(page);
    return response;
  }

  Future<CharacterModel> getCharacter({required int characterId}) async {
    CharacterModel response = await _charactersApi.getCharacter(characterId: characterId);
    return response;
  }

  Future<Map<String, bool>> getFavoritesCharacters() async {
    return await _prefs.getFavoritesCharacter();
  }

  Future saveFavoritesCharacter(int characterId, bool isLiked) async {
    await _prefs.saveFavoritesCharacter(characterId, isLiked);
  }
}
