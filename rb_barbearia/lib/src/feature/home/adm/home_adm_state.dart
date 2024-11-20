import 'package:barbearia_rb/src/model/user_model.dart';

enum HomeAdmStateStatus {
  loaded,
  error
}
class HomeAdmState {
    HomeAdmState({
    required this.status,
    required this.employee
  });

  final HomeAdmStateStatus status;
  final List<UserModel> employee;
  
  HomeAdmState copyWith({
    HomeAdmStateStatus? status,
    List<UserModel>? employee    
  }) {
    return HomeAdmState(
          status: status ?? this.status,
      employee: employee ?? this.employee
    );
  }
}