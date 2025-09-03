class BaseException implements Exception {
  final String message;
  BaseException({
    required this.message,
  });
}

class ServerException extends BaseException {
  ServerException({
    required super.message,
  });
}

class AuthenticationFailedException extends BaseException {
  AuthenticationFailedException({required super.message});
}

class NetworkException extends BaseException {
  NetworkException({required super.message});
}

class TimeoutException extends BaseException {
  TimeoutException({required super.message});
}

class TokenVerificationException extends BaseException {
  TokenVerificationException({required super.message});
}

class TokenRefreshException extends BaseException {
  TokenRefreshException({required super.message});
}

class TokenExpiredException extends BaseException {
  TokenExpiredException({required super.message});
}
