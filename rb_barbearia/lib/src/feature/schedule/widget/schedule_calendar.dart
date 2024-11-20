import 'package:barbearia_rb/src/core/ui/constant.dart';
import 'package:barbearia_rb/src/core/ui/message.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleCalendar extends StatefulWidget {
  ScheduleCalendar(
      {super.key, 
      required this.cancelPressed, 
      required this.okPressed
    });
  final VoidCallback cancelPressed;
 final ValueChanged<DateTime> okPressed;

  @override
  State<ScheduleCalendar> createState() => _ScheduleCalendarState();
}

class _ScheduleCalendarState extends State<ScheduleCalendar> {
  DateTime? selectedDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xffe6e2e9), borderRadius: BorderRadius.circular(16)),
      padding: EdgeInsets.all(10),
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
            availableCalendarFormats: {CalendarFormat.month: 'Month'},
            locale: 'pt_BR',
            calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
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
                onPressed: (){
                  if(selectedDay == null){
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
