sealed class AuthException implements Exception {
  final String message;
  AuthException({required this.message});
}

class AuthErrorException extends AuthException{
  AuthErrorException({required super.message});
}

class AuthUnAuthorizedException extends AuthException{
  AuthUnAuthorizedException() : super(message: '');
  
}

