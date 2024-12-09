import 'dart:developer';
import 'package:barbearia_rb/src/core/ui/constant.dart';
import 'package:barbearia_rb/src/feature/employee/schedule/appointment_ds.dart';
import 'package:barbearia_rb/src/feature/employee/schedule/employee_schedule_vm.dart';
import 'package:barbearia_rb/src/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../../core/ui/widget/babershop_loader.dart';

class EmployeeSchedulePage extends ConsumerStatefulWidget {
  const EmployeeSchedulePage({super.key});

  @override
  ConsumerState<EmployeeSchedulePage> createState() =>
      _EmployeeSchedulePageState();
}

class _EmployeeSchedulePageState extends ConsumerState<EmployeeSchedulePage> {
  late DateTime scheduleDateSelect;

  @override
  void initState() {
    final DateTime(:year, :month, :day) = DateTime.now();
    scheduleDateSelect = DateTime(year, month, day, 0, 0, 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel(id: userId, :name) =
        ModalRoute.of(context)!.settings.arguments as UserModel;
    final asyncSchedule =
        ref.watch(employeeScheduleVmProvider(scheduleDateSelect, userId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agenda'),
      ),
      body: Column(
        children: [
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          ),
          const SizedBox(
            height: 44,
          ),
          asyncSchedule.when(
            loading: () => const BabershopLoader(),
            error: (Object e, StackTrace s) {
              log("Erro ao carregar os agendamentos", error: e, stackTrace: s);
              return const Center(child: Text("Erro ao carregar página"));
            },
            data: (schedules) {
              return Expanded(
                  child: SfCalendar(
                onTap: (calendarTapDetails) {
                  if (calendarTapDetails.appointments != null &&
                      calendarTapDetails.appointments!.isNotEmpty) {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          final dateFormat = DateFormat("dd/MM/yyyy HH:mm:ss");
                          return SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "Cliente: ${calendarTapDetails.appointments?.first.subject}"),
                                    Text(
                                        "Horário: ${dateFormat.format(calendarTapDetails.date ?? DateTime.now())}")
                                  ]),
                            ),
                          );
                        });
                  }
                },
                allowViewNavigation: true,
                view: CalendarView.day,
                showNavigationArrow: true,
                showTodayButton: true,
                showDatePickerButton: true,
                todayHighlightColor: ColorConstant.brow,
                dataSource: AppointmentDs(schedules: schedules),
                //  appointmentBuilder: (context, calendarAppointmentDetails) {
                //  return Container(
                //  decoration: BoxDecoration(
                //     color: ColorConstant.brow,
                //   shape: BoxShape.rectangle,
                //  borderRadius: BorderRadius.circular(5),
                //   ),
                //  child: Center(
                //   child: Text(
                //   calendarAppointmentDetails.appointments.first.subject,
                //  style: const TextStyle(color: Colors.white, fontSize: 12),
                //  ),
                //  ),
                //  );
                // },
              ));
            },
          ),
        ],
      ),
    );
  }
}
