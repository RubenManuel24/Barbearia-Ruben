import 'package:barbearia_rb/src/core/fp/either.dart';
import 'package:barbearia_rb/src/core/providers/application_providers.dart';
import 'package:barbearia_rb/src/feature/auth/register/barbershop/barbershop_register_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'barbershop_register_vm.g.dart';

@riverpod
class BarbershopRegisterVm extends _$BarbershopRegisterVm {
  @override
  BarbershopRegisterState build() => BarbershopRegisterState.initial();

  void addOrRemoveOpenDay(String weekDay) {
    final openingDays = state.openingDays;

    if (openingDays.contains(weekDay)) {
      openingDays.remove(weekDay);
    } else {
      openingDays.add(weekDay);
    }

    state = state.copyWith(openingDays: openingDays);
  }

  void addOrRemoveOpenHours(int dayHours) {
    final openingHours = state.openingHours;

    if (openingHours.contains(dayHours)) {
      openingHours.remove(dayHours);
    } else {
      openingHours.add(dayHours);
    }

    state = state.copyWith(openingHours: openingHours);
  }

  Future<void> register(String name, String email) async {
    final repository = ref.watch(barbershopRepositoryProvider);
    final BarbershopRegisterState(:openingHours, :openingDays) = state;

    final dto = (
      name: name,
      email: email,
      openingDays: openingDays,
      openingHours: openingHours
    );
    
    final registerResult = await repository.save(dto);

    switch(registerResult){
      case Sucess():
      ref.invalidate(getMyBarbershopProvider);
      state = state.copyWith(status: BarbershopRegisterStateStatus.sucess);
      case Failure():
      state = state.copyWith(status: BarbershopRegisterStateStatus.error);
    }

  }
}
