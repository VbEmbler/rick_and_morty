//return  when catched some error when accessing api and response code != 200
class ApiFailure {
  int? code;
  String? errorResponse;
  ApiFailure({this.code, this.errorResponse});
}
