import 'package:asyncstate/asyncstate.dart';
import 'package:barbearia_rb/src/core/fp/either.dart';
import 'package:barbearia_rb/src/core/providers/application_providers.dart';
import 'package:barbearia_rb/src/feature/schedule/schedule_state.dart';
import 'package:barbearia_rb/src/model/barbershop_model.dart';
import 'package:barbearia_rb/src/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'schedule_vm.g.dart';

@riverpod
class ScheduleVm extends _$ScheduleVm {
  @override
  ScheduleState build() => ScheduleState.initial();

  void selectHour(int hour) {
    if (hour == state.scheduleHour) {
      state = state.copyWith(scheduleHour: () => null);
    } else {
      state = state.copyWith(scheduleHour: () => hour);
    }
  }

  void selectDate(DateTime date) {
    state = state.copyWith(scheduleDate: () => date);
  }

  Future<void> register(
      {required UserModel userModel, required String clientName}) async {
    final asyncLoaderHandler = AsyncLoaderHandler()..start();
    final ScheduleState(:scheduleDate, :scheduleHour) = state;
    final BarbershopModel(id: barbershopId) =
        await ref.watch(getMyBarbershopProvider.future);
    final scheduleRepository = ref.read(scheduleRepositoryProvider);

    final dto = (
      barbershopId: barbershopId,
      nameClient: clientName,
      userId: userModel.id,
      date: scheduleDate!,
      time: scheduleHour!,
    );

    final scheduleResult = await scheduleRepository.scheduleClient(dto);

    switch (scheduleResult) {
      case Sucess():
        state = state.copyWith(status: ScheduleStateStatus.sucess);
      case Failure():
        state = state.copyWith(status: ScheduleStateStatus.error);
    }

    asyncLoaderHandler.close();
  }
}
