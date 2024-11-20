import 'dart:developer';

import 'package:asyncstate/asyncstate.dart';
import 'package:barbearia_rb/src/core/exceptions/repository_exception.dart';
import 'package:barbearia_rb/src/core/fp/either.dart';
import 'package:barbearia_rb/src/core/fp/nil.dart';
import 'package:barbearia_rb/src/core/providers/application_providers.dart';
import 'package:barbearia_rb/src/core/ui/widget/babershop_loader.dart';
import 'package:barbearia_rb/src/feature/auth/register/barbershop/barbershop_register_page.dart';
import 'package:barbearia_rb/src/feature/auth/register/barbershop/barbershop_register_state.dart';
import 'package:barbearia_rb/src/feature/employee/register/employee_register_state.dart';
import 'package:barbearia_rb/src/model/barbershop_model.dart';
import 'package:barbearia_rb/src/repositories/user/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'employee_register_vm.g.dart';

@riverpod
class EmployeeRegisterVm extends _$EmployeeRegisterVm {
  @override
  EmployeeRegisterState build() => EmployeeRegisterState.initial();

  void setRegisterADM(bool isRegisterADM) {
    state = state.copyWith(registerADM: isRegisterADM);
  }

  void addOrRemoveWeekDay(String day) {
    final EmployeeRegisterState(:weekDays) = state;

    if (weekDays.contains(day)) {
      weekDays.remove(day);
    } else {
      weekDays.add(day);
    }
    state = state.copyWith(weekDays: weekDays);
  }

  void addOrRemoveWeekHours(int hour) {
    final EmployeeRegisterState(:weekHours) = state;

    if (weekHours.contains(hour)) {
      weekHours.remove(hour);
    } else {
      weekHours.add(hour);
    }

    state = state.copyWith(weekHours: weekHours);
  }

  Future<void> register({String? name, String? email, String? password}) async {
    final asyncLoaderHandler = AsyncLoaderHandler()..start();
    final UserRepository(:registerEmployee, :registerAdmAsEmployee) =
        ref.read(userRepositoryProvider);
    final EmployeeRegisterState(:registerADM, :weekDays, :weekHours) = state;

    final Either<RepositoryException, Nil> resulRegister;

    if (registerADM) {
      final dto = (weekDays: weekDays, weekHours: weekHours);

      resulRegister = await registerAdmAsEmployee(dto);
    } else {
      final BarbershopModel(:id) =
          await ref.watch(getMyBarbershopProvider.future);

      final dto = (
        name: name!,
        email: email!,
        password: password!,
        barbershopId: id,
        weekDays: weekDays,
        weekHours: weekHours
      );

      resulRegister = await registerEmployee(dto);
    }

    switch (resulRegister) {
      case Sucess():
        state = state.copyWith(status: EmployeeRegisterStateStatus.sucess);
      case Failure():
        state = state.copyWith(status: EmployeeRegisterStateStatus.error);
    }
    asyncLoaderHandler.close();
  }
}
