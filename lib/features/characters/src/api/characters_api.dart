import 'package:dio/dio.dart';
import 'package:rick_and_morty/core/api_statuses/api_failure.dart';
import 'package:rick_and_morty/core/api_statuses/api_success.dart';
import 'package:rick_and_morty/core/dio_exceptions.dart';
import 'package:rick_and_morty/features/characters/constants.dart';
import 'package:rick_and_morty/features/characters/models/character_list_model.dart';
import 'package:rick_and_morty/features/characters/models/character_model.dart';

class CharactersApi {
  Future<Object> getCharacterList(String url) async {
    Response response;
    final dio = Dio();
    //String url = '${Constants.baseURL}${Constants.characterEndpoint}';
    try {
      response = await dio.get(url);
      CharacterListModel characterList = CharacterListModel.fromJson(
        response.data,
      );
      return ApiSuccess(response: characterList);
    } on DioException catch (e) {
      if (e.response?.statusCode != null) {
        int? statusCode = e.response!.statusCode;
        String message = DioExceptions.badResponseCode(statusCode).toString();
        throw ApiFailure(code: statusCode, errorResponse: message);
      } else {
        String message = DioExceptions.fromDioError(e).toString();
        throw ApiFailure(errorResponse: message);
      }
    } catch (e) {
      throw ApiFailure(errorResponse: e.toString());
    }
  }

  Future<Object> getCharacter({required int characterId}) async {
    Response response;
    final dio = Dio();
    String url =
        '${Constants.baseURL}${Constants.characterEndpoint}/$characterId';
    try {
      response = await dio.get(url);
      CharacterModel character = CharacterModel.fromJson(response.data);
      return ApiSuccess(response: character);
    } on DioException catch (e) {
      if (e.response?.statusCode != null) {
        int? statusCode = e.response!.statusCode;
        String message = DioExceptions.badResponseCode(statusCode).toString();
        throw ApiFailure(code: statusCode, errorResponse: message);
      } else {
        String message = DioExceptions.fromDioError(e).toString();
        throw ApiFailure(errorResponse: message);
      }
    } catch (e) {
      throw ApiFailure(errorResponse: e.toString());
    }
  }
}
