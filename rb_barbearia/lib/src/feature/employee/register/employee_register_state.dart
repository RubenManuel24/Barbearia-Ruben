enum EmployeeRegisterStateStatus {
  initial,
  sucess,
  error
}
class EmployeeRegisterState {
      EmployeeRegisterState({
    required this.status,
    required this.registerADM,
    required this.weekDays,
    required this.weekHours
  });


  EmployeeRegisterState.initial() : this(
    status: EmployeeRegisterStateStatus.initial,
    registerADM: false,
    weekDays: [],
    weekHours: []
     );

  final EmployeeRegisterStateStatus status;
  final bool registerADM;
  final List<String> weekDays;
  final List<int> weekHours;
  
  EmployeeRegisterState copyWith({
    EmployeeRegisterStateStatus? status,
    bool? registerADM,
    List<String>? weekDays,
    List<int>? weekHours    
  }) {
    return EmployeeRegisterState(
          status: status ?? this.status,
      registerADM: registerADM ?? this.registerADM,
      weekDays: weekDays ?? this.weekDays,
      weekHours: weekHours ?? this.weekHours
    );
  }
}