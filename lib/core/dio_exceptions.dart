import 'package:dio/dio.dart';
import 'package:rick_and_morty/core/utils/language_utils.dart';

class DioExceptions implements Exception {
  String _message = '';

  //handle error without response code
  DioExceptions.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        _message = LanguageUtils.requestToAPIServerWasCancelled;
        break;
      case DioExceptionType.connectionTimeout:
        _message = LanguageUtils.connectionTimeoutWithAPIServer;
        break;
      case DioExceptionType.connectionError:
        _message =
            LanguageUtils.connectionToAPIServerFailedDueToInternetConnection;
        break;
      case DioExceptionType.receiveTimeout:
        _message = LanguageUtils.receiveTimeoutInConnectionWithAPIServer;
        break;
      case DioExceptionType.sendTimeout:
        _message = LanguageUtils.sendTimeoutInConnectionWithAPIServer;
        break;
      default:
        _message = LanguageUtils.somethingWentWrong;
        break;
    }
  }

  //handle error with response code != 200
  DioExceptions.badResponseCode(int? statusCode) {
    _message = _handleError(statusCode);
  }

  String _handleError(int? statusCode) {
    switch (statusCode) {
      case 400:
        return LanguageUtils.somethingWentWrong;
      case 404:
        return LanguageUtils.somethingWentWrong;
      case 500:
        return LanguageUtils.internalServerError;
      default:
        return LanguageUtils.somethingWentWrong;
    }
  }

  @override
  String toString() {
    return _message;
  }
}
