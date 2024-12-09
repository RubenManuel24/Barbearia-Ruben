import 'package:barbearia_rb/src/core/ui/constant.dart';
import 'package:barbearia_rb/src/core/ui/message.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleCalendar extends StatefulWidget {
  const ScheduleCalendar({
        super.key, 
        required this.cancelPressed, 
        required this.okPressed, 
        required this.weekDays
        });

  final VoidCallback cancelPressed;
  final ValueChanged<DateTime> okPressed;
  final List<dynamic> weekDays;

  @override
  State<ScheduleCalendar> createState() => _ScheduleCalendarState();
}

class _ScheduleCalendarState extends State<ScheduleCalendar> {
  DateTime? selectedDay;
  late final List<int> weekDayEnable;
   
  int conertWeekDays(var day){

    return switch(day.toLowerCase()){
      "seg" => DateTime.monday,
      "ter" => DateTime.tuesday,
      "qua" => DateTime.wednesday,
      "qui" => DateTime.thursday,
      "sex" => DateTime.friday,
      "sab" => DateTime.saturday,
      "dom" => DateTime.sunday,
       _ => 0
    };

  }

   @override
  void initState() {
    weekDayEnable = widget.weekDays.map(conertWeekDays).toList();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color(0xffe6e2e9),
          borderRadius: BorderRadius.circular(16)),
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          TableCalendar(
            availableGestures: AvailableGestures.none,
            focusedDay: DateTime.now(),
            firstDay: DateTime.utc(2010, 01, 01),
            lastDay: DateTime.now().add(const Duration(days: 365 * 10)),
            calendarFormat: CalendarFormat.month,
            formatAnimationCurve: Curves.easeInBack,
            headerStyle: const HeaderStyle(titleCentered: true),
            enabledDayPredicate: (day) {
              return weekDayEnable.contains(day.weekday);
            },
            availableCalendarFormats: {CalendarFormat.month: 'Month'},
            locale: 'pt_BR',
            calendarStyle: CalendarStyle(
                selectedDecoration: const BoxDecoration(
                    color: ColorConstant.brow, shape: BoxShape.circle),
                todayDecoration: BoxDecoration(
                    color: ColorConstant.brow.withOpacity(0.5),
                    shape: BoxShape.circle)),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                this.selectedDay = selectedDay;
              });
            },
            selectedDayPredicate: (day) {
              return isSameDay(selectedDay, day);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: widget.cancelPressed,
                child: const Text(
                  'Cancelar',
                  style: TextStyle(
                      color: ColorConstant.brow,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (selectedDay == null) {
                    Message.showErro('Por favor selecione uma data', context);
                    return;
                  }
                  widget.okPressed(selectedDay!);
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                      color: ColorConstant.brow,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
