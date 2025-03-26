import 'package:dio/dio.dart';

import 'package:rick_and_morty/models/character_list_model.dart';
import 'package:rick_and_morty/models/character_model.dart';

class CharactersApi {
  static const _baseURL = "https://rickandmortyapi.com/api";

  final _dio = Dio();

  CharactersApi() {
    _initDio();
  }

  _initDio() {
    _dio.options
      ..baseUrl = _baseURL
      ..connectTimeout = const Duration(seconds: 30)
      ..receiveTimeout = const Duration(seconds: 60)
      ..sendTimeout = const Duration(seconds: 30);
  }

  Future<CharacterListModel> getCharacterList(int? page) async {
    final Response response = await _dio.get('/character', queryParameters: {'page': page});
    CharacterListModel characterList = CharacterListModel.fromJson(response.data);
    return characterList;
  }

  Future<CharacterModel> getCharacter({required int characterId}) async {
    final Response response = await _dio.get('/character/$characterId');
    CharacterModel character = CharacterModel.fromJson(response.data);
    return character;
  }
}
