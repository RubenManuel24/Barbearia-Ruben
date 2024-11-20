// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:barbearia_rb/src/core/constants/local_storage_keys.dart';
import 'package:barbearia_rb/src/core/exceptions/auth_exception.dart';
import 'package:barbearia_rb/src/core/exceptions/service_exception.dart';
import 'package:barbearia_rb/src/core/fp/either.dart';
import 'package:barbearia_rb/src/core/fp/nil.dart';
import 'package:barbearia_rb/src/repositories/user/user_repository.dart';
import 'package:barbearia_rb/src/service/user_login/user_login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLoginServiceImpl implements UserLoginService {
  final UserRepository userRepository;
  UserLoginServiceImpl({
    required this.userRepository,
  });

  @override
  Future<Either<ServiceException, Nil>> execute(
      String email, String password) async {
    final loginResult = await userRepository.login(email, password);

    switch (loginResult) {
      case Sucess(value: final accessToken):
        final sp = await SharedPreferences.getInstance();
        sp.setString(LocalStorageKeys.accessToken, accessToken);
        return Sucess(nil);

      case Failure(:final exception):
        switch (exception) {
          case AuthErrorException():
            return Failure(ServiceException('Erro ao fazer login'));
          case AuthUnAuthorizedException():
            return Failure(ServiceException('Email ou senha inválida'));
        }

      // OU podemos fazer desta forma
      // return switch (exception) {
      //  AuthErrorException() => Failure(ServiceException('')),
      // AuthUnAuthorizedException() => Failure(ServiceException(''))
    }
    
  }
}
