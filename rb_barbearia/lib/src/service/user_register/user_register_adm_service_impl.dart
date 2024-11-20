import 'package:barbearia_rb/src/core/exceptions/service_exception.dart';

import 'package:barbearia_rb/src/core/fp/either.dart';
import 'package:barbearia_rb/src/core/fp/nil.dart';
import 'package:barbearia_rb/src/repositories/user/user_repository.dart';
import 'package:barbearia_rb/src/service/user_login/user_login_service.dart';

import 'user_register_adm_service.dart';

class UserRegisterAdmServiceImpl implements UserRegisterAdmService {

    UserRegisterAdmServiceImpl({
      required this.userRepository, 
      required this.userLoginService,
      });
  
  final UserRepository userRepository;
  final UserLoginService userLoginService;

  @override
  Future<Either<ServiceException, Nil>> execute(({String email, String name, String password}) userData) async {

    final resultResgister = await userRepository.registerAdmin(userData);

    switch(resultResgister){
      case Sucess():
        return userLoginService.execute(userData.email, userData.password);
      case Failure(: final exception):
        return Failure(ServiceException(exception.message));
    }
  }
}