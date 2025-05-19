class ApiException implements Exception {
  final String message;

  ApiException(this.message);

  @override
  String toString() => message;
}

class ServerException extends ApiException {
  ServerException(super.message);
}

class TimeoutException extends ApiException {
  TimeoutException() : super('Request timeout. Please try again.');
}
