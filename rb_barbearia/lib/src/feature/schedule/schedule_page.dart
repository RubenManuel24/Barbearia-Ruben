import 'package:barbearia_rb/src/core/ui/constant.dart';
import 'package:barbearia_rb/src/core/ui/helpers/form_helpers.dart';
import 'package:barbearia_rb/src/core/ui/message.dart';
import 'package:barbearia_rb/src/core/ui/widget/avatar_widget.dart';
import 'package:barbearia_rb/src/core/ui/widget/barbershop_icon.dart';
import 'package:barbearia_rb/src/core/ui/widget/hours_painel.dart';
import 'package:barbearia_rb/src/feature/schedule/schedule_state.dart';
import 'package:barbearia_rb/src/feature/schedule/schedule_vm.dart';
import 'package:barbearia_rb/src/feature/schedule/widget/schedule_calendar.dart';
import 'package:barbearia_rb/src/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';
import 'package:intl/intl.dart';

class SchedulePage extends ConsumerStatefulWidget {
  const SchedulePage({super.key});

  @override
  ConsumerState<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends ConsumerState<SchedulePage> {
  var dateFormat = DateFormat('dd/MM/yyyy');
  final form = GlobalKey<FormState>();
  final clientEC = TextEditingController();
  final dateEC = TextEditingController();
  bool showCalender = false;

  @override
  void dispose() {
    clientEC.dispose();
    dateEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userModel = ModalRoute.of(context)!.settings.arguments as UserModel;

    final scheduleVm = ref.watch(scheduleVmProvider.notifier);

    final employeeData = switch (userModel) {
      UserModelADM(:final workDays!, :final workHours!) => (
          workDays: workDays,
          workHours: workHours
        ),
      UserModelEmployee(:final workDays, :final workHours) => (
          workDays: workDays,
          workHours: workHours
        )
    };

    ref.listen(scheduleVmProvider.select((state) => state.status), (_, status) {
      switch (status) {
        case ScheduleStateStatus.initial:
          break;
        case ScheduleStateStatus.sucess:
          Message.showSucess("Cliente agendado com sucesso", context);
          Navigator.of(context).pop();
        case ScheduleStateStatus.error:
          Message.showErro("Erro ao registar agendamento", context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Agendar cliente'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: form,
            child: Center(
              child: Column(
                children: [
                  const AvatarWidget(
                    hideUploadButton: true,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    userModel.name,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 37),
                  TextFormField(
                    controller: clientEC,
                    validator: Validatorless.required('Cliente obrigatório'),
                    decoration: const InputDecoration(label: Text('Cliente')),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    onTap: () {
                      setState(() {
                        showCalender = true;
                      });
                      unFocus(context);
                    },
                    controller: dateEC,
                    validator: Validatorless.required(
                        'Selecione a data do agendamento'),
                    readOnly: true,
                    decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        label: Text('Selecione uma data'),
                        hintText: 'Selecione uma data',
                        suffixIcon: Icon(
                          BarbershopIcon.calendar,
                          color: ColorConstant.brow,
                        )),
                  ),
                  Offstage(
                    offstage: !showCalender,
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        ScheduleCalendar(
                          weekDays: employeeData.workDays,
                          cancelPressed: () {
                            setState(() {
                              showCalender = false;
                            });
                          },
                          okPressed: (DateTime value) {
                            scheduleVm.selectDate(value);
                            setState(() {
                              dateEC.text = dateFormat.format(value);
                              showCalender = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  HoursPainel.singleSelection(
                    startTime: 6,
                    endTime: 23,
                    onHoursPressed: scheduleVm.selectHour,
                    enableHours: employeeData.workHours,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.brow,
                        minimumSize: const Size.fromHeight(56)),
                    onPressed: () {
                      switch (form.currentState?.validate()) {
                        case null || false:
                          Message.showErro('Dados incompletos', context);
                          return;
                        case true:
                          final selectHour = ref.read(scheduleVmProvider
                              .select((state) => state.scheduleHour != null));
                          if (selectHour) {
                            //register
                            scheduleVm.register(
                                userModel: userModel,
                                clientName: clientEC.text);
                          } else {
                            Message.showErro(
                                "Por favor selecione um horário de atendimento",
                                context);
                          }
                      }
                    },
                    child: const Text('AGENDAR'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
