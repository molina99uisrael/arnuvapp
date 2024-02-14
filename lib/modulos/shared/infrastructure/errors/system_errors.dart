
class ConnectionTimeout implements Exception {}
class InvalidToken implements Exception {}
class WrongCredentials implements Exception {}

class SystemException implements Exception {
  final String message;

  // final int errorCode;
  SystemException(this.message) ;
}

