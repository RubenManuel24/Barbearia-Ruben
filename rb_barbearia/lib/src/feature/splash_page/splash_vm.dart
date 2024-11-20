import 'package:barbearia_rb/src/core/constants/local_storage_keys.dart';
import 'package:barbearia_rb/src/core/providers/application_providers.dart';
import 'package:barbearia_rb/src/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'splash_vm.g.dart';

enum SplashState { initial, login, loggedADM, loggedEmployee, error }

@riverpod
class SplashVm extends _$SplashVm {
  @override
  Future<SplashState> build() async {
    final sp = await SharedPreferences.getInstance();

    if (sp.containsKey(LocalStorageKeys.accessToken)) {


      ref.invalidate(getMeProvider);
      ref.invalidate(getMyBarbershopProvider);

      final userModel = await ref.watch(getMeProvider.future);

      try {
        return switch (userModel) {
          UserModelADM() => SplashState.loggedADM,
          UserModelEmployee() => SplashState.loggedEmployee
        };
      } catch (e) {
        return SplashState.login;
      }
    }
      return SplashState.login;
  }
}
