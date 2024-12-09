import 'package:flutter/material.dart';
enum ScheduleStateStatus{
  initial,
  sucess,
  error
}

class ScheduleState{
    ScheduleState({
    required this.status,
    this.scheduleDate,
    this.scheduleHour
  });

  ScheduleState.initial(): this(status: ScheduleStateStatus.initial);

  final ScheduleStateStatus status;
  final DateTime? scheduleDate;
  final int? scheduleHour;
  ScheduleState copyWith({
    ScheduleStateStatus? status,
    ValueGetter<DateTime?>? scheduleDate,
    ValueGetter<int?>? scheduleHour    
  }) {
    return ScheduleState(
          status: status ?? this.status,
      scheduleDate: scheduleDate != null ? scheduleDate() : this.scheduleDate,
      scheduleHour: scheduleHour != null ? scheduleHour() : this.scheduleHour
    );
  }
}