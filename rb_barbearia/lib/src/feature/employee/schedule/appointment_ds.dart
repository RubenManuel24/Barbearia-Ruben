import 'package:barbearia_rb/src/model/schedule_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class AppointmentDs extends CalendarDataSource {
  AppointmentDs({
    required this.schedules
  });

  final List<ScheduleModel> schedules;
  @override
  List<dynamic> get appointments {

    return schedules.map((e) {

      final ScheduleModel(
        date: DateTime(:year,: month, :day), 
        : hour, 
        : clientName) = e;

        final startTime = DateTime(year, month, day, 0, 0, 0);
        final endTime = DateTime(year, month, day, 0, 0, 0);

      return  Appointment(
          subject: clientName,
          startTime:startTime,
          endTime: endTime
        );
    }).toList();
  }
      
}
