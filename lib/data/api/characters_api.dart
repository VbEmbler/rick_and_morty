import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rick_and_morty/data/network/api_failure.dart';
import 'package:rick_and_morty/data/network/api_success.dart';
import 'package:rick_and_morty/data/network/dio_exceptions.dart';
import 'package:rick_and_morty/data/network/network_failure.dart';
import 'package:rick_and_morty/language_utils.dart';
import 'package:rick_and_morty/models/character_list_model.dart';
import 'package:rick_and_morty/models/character_model.dart';

class CharactersApi {
  static const _baseURL = "https://rickandmortyapi.com/api";
  static const _characterEndpoint = "character";
  static const _characterListPageEndpoint = "?page";
  final _dio = Dio();
  final InternetConnectionChecker _connectionChecker =
      InternetConnectionChecker.instance;

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

  Future<Object> getCharacterList(int? page) async {
    if (page == null) {
      return await doRequest('/$_characterEndpoint/', true) as ApiSuccess;
    } else {
      return await doRequest(
              '/$_characterEndpoint/$_characterListPageEndpoint=$page', true)
          as ApiSuccess;
    }
  }

  Future<Object> getCharacter({required int characterId}) async {
    return await doRequest('/$_characterEndpoint/$characterId', false)
        as ApiSuccess;
  }

  Future<Object> doRequest(String endpoint, bool isCharacterList) async {
    Response response;
    bool isConnected = await _connectionChecker.hasConnection;
    if (isConnected) {
      try {
        response = await _dio.get(endpoint);

        if (isCharacterList) {
          CharacterListModel characterList = CharacterListModel.fromJson(
            response.data,
          );
          return ApiSuccess(response: characterList);
        } else {
          response = await _dio.get(endpoint);
          CharacterModel character = CharacterModel.fromJson(response.data);
          return ApiSuccess(response: character);
        }
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
    } else {
      throw NetworkFailure(LanguageUtils.checkYourInetConnections);
    }
  }
}
