import 'package:barbearia_rb/src/core/fp/either.dart';
import 'package:barbearia_rb/src/core/providers/application_providers.dart';
import 'package:barbearia_rb/src/model/schedule_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'employee_schedule_vm.g.dart';

@riverpod
class EmployeeScheduleVm extends _$EmployeeScheduleVm{

  @override
  Future<List<ScheduleModel>> build(DateTime date, int userId) async {

    final repository = ref.read(scheduleRepositoryProvider);
    final scheduleList = await repository.findScheduleByDate((date: date, userId: userId));

   return switch(scheduleList){
      Sucess(value: final schedules) => schedules,
      Failure(: final exception) => throw  Exception(exception)
    };
  }

}