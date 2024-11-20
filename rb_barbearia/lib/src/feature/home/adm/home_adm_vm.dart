import 'package:asyncstate/asyncstate.dart';
import 'package:barbearia_rb/src/core/fp/either.dart';
import 'package:barbearia_rb/src/core/providers/application_providers.dart';
import 'package:barbearia_rb/src/feature/home/adm/home_adm_state.dart';
import 'package:barbearia_rb/src/model/barbershop_model.dart';
import 'package:barbearia_rb/src/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'home_adm_vm.g.dart';

@riverpod
class HomeAdmVm extends _$HomeAdmVm {
  @override
  Future<HomeAdmState> build() async {

    final repository = ref.read(userRepositoryProvider);

    final BarbershopModel(id: barbershopId) = await ref.read(getMyBarbershopProvider.future);

    final me = await ref.read(getMeProvider.future);

    final resultEmployee = await repository.getEmployee(barbershopId);

    switch (resultEmployee) {
      case Sucess(value: final employeesData):
      final employees = <UserModel>[];

        if(me case UserModelADM(workDays: _?, workHours: _?)){
          employees.add(me);
        }

        employees.addAll(employeesData);

       return HomeAdmState(status: HomeAdmStateStatus.loaded, employee: employees);
      case Failure():
        return HomeAdmState(status: HomeAdmStateStatus.error, employee: []);
    }
  }

  Future<void> logout() async => ref.read(logoutProvider.future).asyncLoader();
}
