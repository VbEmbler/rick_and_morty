import 'package:rick_and_morty/core/api_statuses/api_failure.dart';
import 'package:rick_and_morty/core/api_statuses/api_success.dart';
import 'package:rick_and_morty/core/platform/network_failure.dart';
import 'package:rick_and_morty/core/platform/network_info.dart';
import 'package:rick_and_morty/core/utils/language_utils.dart';
import 'package:rick_and_morty/features/characters/src/api/characters_api.dart';

class CharactersRemoteRepository {
  final NetworkInfo networkInfo;
  final CharactersApi charactersApi;

  CharactersRemoteRepository({
    required this.networkInfo,
    required this.charactersApi,
  });

  Future<Object> getCharacterList(String url) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        ApiSuccess response =
            await charactersApi.getCharacterList(url) as ApiSuccess;
        return response;
      } on ApiFailure catch (e) {
        ApiFailure apiFailure = ApiFailure();
        if (e.code != null) {
          apiFailure = ApiFailure(code: e.code, errorResponse: e.errorResponse);
        } else {
          apiFailure = ApiFailure(errorResponse: e.errorResponse);
        }
        throw apiFailure;
      } catch (e) {
        throw ApiFailure(errorResponse: e.toString());
      }
    } else {
      throw NetworkFailure(LanguageUtils.checkYourInetConnections);
    }
  }

  Future<Object> getCharacter({required int characterId}) async {
    bool isConnected = await networkInfo.isConnected;
    if (isConnected) {
      try {
        ApiSuccess response = await charactersApi.getCharacter(
            characterId: characterId) as ApiSuccess;
        return response;
      } on ApiFailure catch (e) {
        ApiFailure apiFailure = ApiFailure();
        if (e.code != null) {
          apiFailure = ApiFailure(code: e.code, errorResponse: e.errorResponse);
        } else {
          apiFailure = ApiFailure(errorResponse: e.errorResponse);
        }
        throw apiFailure;
      } catch (e) {
        throw ApiFailure(errorResponse: e.toString());
      }
    } else {
      throw NetworkFailure(LanguageUtils.checkYourInetConnections);
    }
  }
}
