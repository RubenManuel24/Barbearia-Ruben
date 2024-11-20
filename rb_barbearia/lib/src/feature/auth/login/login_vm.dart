import 'package:asyncstate/asyncstate.dart';
import 'package:barbearia_rb/src/core/exceptions/service_exception.dart';
import 'package:barbearia_rb/src/core/fp/either.dart';
import 'package:barbearia_rb/src/core/providers/application_providers.dart';
import 'package:barbearia_rb/src/feature/auth/login/login_state.dart';
import 'package:barbearia_rb/src/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_vm.g.dart';

@riverpod
class LoginVm extends _$LoginVm {

  @override
  LoginState build() => LoginState.initial();

  Future<void> login(String email, String password) async {
    final loaderHandler = AsyncLoaderHandler()..start();

    final loginService = ref.watch(userLoginServiceProvider);

    final result = await loginService.execute(email, password);

    switch (result) {
      case Sucess():
        //! Invalidando os caches para evitar login com usuário inválidos
        ref.invalidate(getMeProvider);
        ref.invalidate(getMyBarbershopProvider);
        final userModel = await ref.read(getMeProvider.future);
        switch(userModel){
          case UserModelADM():
            state = state.CopyWith(status: LoginStateStatus.admLogin);
          case UserModelEmployee():
            state = state.CopyWith(status: LoginStateStatus.empleyeeLogin);
        }
        break;
      case Failure(exception: ServiceException(:final message)):
        state = state.CopyWith(
              status: LoginStateStatus.error, 
              errorMessage: () => message
            );
    }

    loaderHandler.close();
  }
}
