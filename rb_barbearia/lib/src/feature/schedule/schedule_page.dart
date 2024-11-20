import 'package:barbearia_rb/src/core/ui/constant.dart';
import 'package:barbearia_rb/src/core/ui/helpers/form_helpers.dart';
import 'package:barbearia_rb/src/core/ui/message.dart';
import 'package:barbearia_rb/src/core/ui/widget/avatar_widget.dart';
import 'package:barbearia_rb/src/core/ui/widget/barbershop_icon.dart';
import 'package:barbearia_rb/src/core/ui/widget/hours_painel.dart';
import 'package:barbearia_rb/src/feature/schedule/widget/schedule_calendar.dart';
import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';
import 'package:intl/intl.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
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
                  const Text(
                    'Nome e Sobrenome',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
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
                    validator: Validatorless.required('Selecione a data do agendamento'),
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
                   child:  Column(
                      children: [
                        const SizedBox(height: 24),
                         ScheduleCalendar(
                          cancelPressed: () { 
                            setState(() {
                              showCalender = false
                              ;
                            });
                           }, 
                          okPressed: (DateTime value) {
                            setState(() {
                                dateEC.text = dateFormat.format(value);
                              showCalender = false;
                            });
                            },),
                      ],
                    ),
                 ),
                  const SizedBox(height: 24),
                  HoursPainel(
                    startTime: 6,
                    endTime: 23,
                    onHoursPressed: (hours) {},
                    enableHours: const [8, 9, 10, 11, 14, 15, 16],
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstant.brow,
                        minimumSize: const Size.fromHeight(56)),
                    onPressed: () {
                      switch(form.currentState?.validate()){
                        case null || false :
                        Message.showErro('Dados incompletos', context);
                        return;
                        case true:
                        // Validar o VM

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
