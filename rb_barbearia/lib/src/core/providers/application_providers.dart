import 'package:barbearia_rb/src/core/fp/either.dart';
import 'package:barbearia_rb/src/core/restClient/rest_client.dart';
import 'package:barbearia_rb/src/core/ui/barbershop_nav_globa_key.dart';
import 'package:barbearia_rb/src/model/barbershop_model.dart';
import 'package:barbearia_rb/src/model/user_model.dart';
import 'package:barbearia_rb/src/repositories/barbershop.dart/barbershop_repository.dart';
import 'package:barbearia_rb/src/repositories/barbershop.dart/barbershop_repository_impl.dart';
import 'package:barbearia_rb/src/repositories/schedule/schedule_repository.dart';
import 'package:barbearia_rb/src/repositories/schedule/schedule_repository_impl.dart';
import 'package:barbearia_rb/src/repositories/user/user_repository.dart';
import 'package:barbearia_rb/src/repositories/user/user_repository_impl.dart';
import 'package:barbearia_rb/src/service/user_login/user_login_service.dart';
import 'package:barbearia_rb/src/service/user_login/user_login_service_impl.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'application_providers.g.dart';

@Riverpod(keepAlive: true)
RestClient restClient(RestClientRef ref) => RestClient();

@Riverpod(keepAlive: true)
UserRepository userRepository(UserRepositoryRef ref) =>
    UserRepositoryImpl(restClient: ref.read(restClientProvider));

@Riverpod(keepAlive: true)
UserLoginService userLoginService(UserLoginServiceRef ref) =>
    UserLoginServiceImpl(userRepository: ref.read(userRepositoryProvider));

@Riverpod(keepAlive: true)
Future<UserModel> getMe(GetMeRef ref) async {
  final resul = await ref.watch(userRepositoryProvider).me();

  return switch (resul) {
    Failure(:final exception) => throw exception,
    Sucess(value: final userModel) => userModel
  };
}

@Riverpod(keepAlive: true)
BarbershopRepository barbershopRepository(BarbershopRepositoryRef ref) =>
    BarbershopRepositoryImpl(restClient: ref.watch(restClientProvider));

@Riverpod(keepAlive: true)
Future<BarbershopModel> getMyBarbershop(GetMyBarbershopRef ref) async {
  final userModel = await ref.watch(getMeProvider.future);

  final barbershopRepository = await ref.watch(barbershopRepositoryProvider);

  final result = await barbershopRepository.getMyBarbershop(userModel);

  return switch (result) {
    Sucess(value: final barbershop) => barbershop,
    Failure(:final exception) => throw exception,
  };
}

@riverpod
Future<void> logout(LogoutRef ref) async {
  final sp = await SharedPreferences.getInstance();
  sp.clear();

  ref.invalidate(getMeProvider);
  ref.invalidate(getMyBarbershopProvider);
  Navigator.of(BarbershopNavGlobaKey.instance.navKey.currentContext!)
      .pushNamedAndRemoveUntil('/auth/login', (route) => false);
}

@riverpod
ScheduleRepository scheduleRepository(ScheduleRepositoryRef ref) =>
    ScheduleRepositoryImpl(restClient: ref.read(restClientProvider));
