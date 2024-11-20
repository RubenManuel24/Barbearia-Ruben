import 'package:asyncstate/asyncstate.dart';
import 'package:barbearia_rb/src/barbershop_app.dart';
import 'package:barbearia_rb/src/core/fp/either.dart';
import 'package:barbearia_rb/src/core/providers/application_providers.dart';
import 'package:barbearia_rb/src/feature/auth/register/user/user_register_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'user_register_vm.g.dart';

enum UserRegisterStateStatus  {
  initial,
  sucess,
  error
}

@riverpod
class UserRegisterVm extends _$UserRegisterVm {
  
  @override
  UserRegisterStateStatus build() => UserRegisterStateStatus.initial;

  Future<void> userRegister({
    required String name, 
    required String email, 
    required String password
    }) async {

      final userRegisterAdmService = ref.watch(userRegisterAdmServiceProvider);

      final userDTO = (
        name: name,
        email: email,
        password: password
      );

      final registerResult = await userRegisterAdmService.execute(userDTO).asyncLoader();

      switch(registerResult){
        case Sucess():
        ref.invalidate(getMeProvider);
        state = UserRegisterStateStatus.sucess;
        case Failure():
         state = UserRegisterStateStatus.error;
      }

  }
  
}