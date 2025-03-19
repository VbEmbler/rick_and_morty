import 'package:internet_connection_checker/internet_connection_checker.dart';

class NetworkInfo {
  final InternetConnectionChecker _connectionChecker;

  NetworkInfo(this._connectionChecker);

  //check internet connection
  Future<bool> get isConnected => _connectionChecker.hasConnection;
}