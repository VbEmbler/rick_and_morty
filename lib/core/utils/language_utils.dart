class LanguageUtils {
  static String defaultLanguage = 'en';
  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'applicationName': 'Rick And Morty',
      'requestToAPIServerWasCancelled': 'Request to API server was cancelled',
      'connectionTimeoutWithAPIServer': 'Connection timeout with API server',
      'connectionToAPIServerFailedDueToInternetConnection':
          'Connection to API server failed due to internet connection',
      'receiveTimeoutInConnectionWithAPIServer':
          'Receive timeout in connection with API server',
      'sendTimeoutInConnectionWithAPIServer':
          'Send timeout in connection with API server',
      'somethingWentWrong': 'Something went wrong',
      'badRequest': 'Bad request',
      'internalServerError': 'Internal server error',
      'checkYourInetConnections': 'Check your inet Connections',
      'connectionError': 'Connection error',
      'errorCode': 'Error code',
      'errorMessage': 'Error message',
      'errorGettingData': 'Error getting data',
    },
  };

  static set language(String lang) {
    defaultLanguage = lang;
  }

  static String get applicationName {
    return _localizedValues[defaultLanguage]!['applicationName']!;
  }

  static String get requestToAPIServerWasCancelled {
    return _localizedValues[defaultLanguage]![
        'requestToAPIServerWasCancelled']!;
  }

  static String get connectionTimeoutWithAPIServer {
    return _localizedValues[defaultLanguage]![
        'connectionTimeoutWithAPIServer']!;
  }

  static String get connectionToAPIServerFailedDueToInternetConnection {
    return _localizedValues[defaultLanguage]![
        'connectionToAPIServerFailedDueToInternetConnection']!;
  }

  static String get receiveTimeoutInConnectionWithAPIServer {
    return _localizedValues[defaultLanguage]![
        'receiveTimeoutInConnectionWithAPIServer']!;
  }

  static String get sendTimeoutInConnectionWithAPIServer {
    return _localizedValues[defaultLanguage]![
        'sendTimeoutInConnectionWithAPIServer']!;
  }

  static String get somethingWentWrong {
    return _localizedValues[defaultLanguage]!['somethingWentWrong']!;
  }

  static String get badRequest {
    return _localizedValues[defaultLanguage]!['badRequest']!;
  }

  static String get internalServerError {
    return _localizedValues[defaultLanguage]!['internalServerError']!;
  }

  static String get checkYourInetConnections {
    return _localizedValues[defaultLanguage]!['checkYourInetConnections']!;
  }

  static String get connectionError {
    return _localizedValues[defaultLanguage]!['connectionError']!;
  }

  static String get errorCode {
    return _localizedValues[defaultLanguage]!['errorCode']!;
  }

  static String get errorMessage {
    return _localizedValues[defaultLanguage]!['errorMessage']!;
  }

  static String get errorGettingData {
    return _localizedValues[defaultLanguage]!['errorGettingData']!;
  }
}
