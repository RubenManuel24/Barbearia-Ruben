import 'dart:developer';
import 'package:barbearia_rb/src/core/providers/application_providers.dart';
import 'package:barbearia_rb/src/core/ui/message.dart';
import 'package:barbearia_rb/src/core/ui/widget/babershop_loader.dart';
import 'package:barbearia_rb/src/feature/employee/register/employee_register_state.dart';
import 'package:barbearia_rb/src/feature/employee/register/employee_register_vm.dart';
import 'package:barbearia_rb/src/model/barbershop_model.dart';
import 'package:flutter/material.dart';
import 'package:barbearia_rb/src/core/ui/constant.dart';
import 'package:barbearia_rb/src/core/ui/widget/hours_painel.dart';
import 'package:barbearia_rb/src/core/ui/widget/avatar_widget.dart';
import 'package:barbearia_rb/src/core/ui/widget/weekdays_painel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class EmployeeRegisterPage extends ConsumerStatefulWidget {
  const EmployeeRegisterPage({super.key});

  @override
  ConsumerState<EmployeeRegisterPage> createState() =>
      _EmployeeRegisterPageState();
}

class _EmployeeRegisterPageState extends ConsumerState<EmployeeRegisterPage> {
  bool employeeRegisterADM = false;
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();
  final passwordEC = TextEditingController();

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final employeeRegisterVm = ref.watch(employeeRegisterVmProvider.notifier);
    final barberAsyncValue = ref.watch(getMyBarbershopProvider);

    ref.listen(employeeRegisterVmProvider.select((state) => state.status),
        (_, status) {
      switch (status) {
        case EmployeeRegisterStateStatus.initial:
          break;
        case EmployeeRegisterStateStatus.error:
          Message.showErro('EErro ao registar colaborador', context);
        case EmployeeRegisterStateStatus.sucess:
          Message.showSucess('Colaborador cadastrado com sucesso', context);
          Navigator.of(context).pop();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar colaborador'),
      ),
      body: barberAsyncValue.when(
        error: (error, stackTrace) {
          log('Erro ao carregar página', error: error, stackTrace: stackTrace);
          return const Center(
            child: Text('Erro ao carregar página'),
          );
        },
        loading: () {
          return const BabershopLoader();
        },
        data: (barberAsyncValue) {
          final BarbershopModel(:openingDays, :openingHours) = barberAsyncValue;

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: formKey,
                child: Center(
                  child: Column(
                    children: [
                      const AvatarWidget(),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          Checkbox.adaptive(
                            value: employeeRegisterADM,
                            onChanged: (value) {
                              setState(() {
                                employeeRegisterADM = !employeeRegisterADM;
                                employeeRegisterVm
                                    .setRegisterADM(employeeRegisterADM);
                              });
                            },
                            activeColor: ColorConstant.brow,
                          ),
                          const Expanded(
                            child: Text(
                              'Sou administrador e quero me cadastrar como colaborador',
                              style: TextStyle(fontSize: 14),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 24),
                      Offstage(
                        offstage: employeeRegisterADM,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: nameEC,
                              validator: employeeRegisterADM
                                  ? null
                                  : Validatorless.required('Nome obrigatório'),
                              decoration: const InputDecoration(
                                label: Text('Nome'),
                              ),
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              controller: emailEC,
                              validator: employeeRegisterADM
                                  ? null
                                  : Validatorless.multiple([
                                      Validatorless.required(
                                          'E-mail obrigatório'),
                                      Validatorless.email('E-mail inválido')
                                    ]),
                              decoration: const InputDecoration(
                                label: Text('E-mail'),
                              ),
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              controller: passwordEC,
                              validator: employeeRegisterADM
                                  ? null
                                  : Validatorless.multiple([
                                      Validatorless.required(
                                          'Senha obrigatório'),
                                      Validatorless.min(
                                          6, 'Senha no mínimo 6 caracteres')
                                    ]),
                              decoration: const InputDecoration(
                                label: Text('Senha'),
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: WeekdaysPainel(
                            enableDay: openingDays,
                            onDayPressed:
                                employeeRegisterVm.addOrRemoveWeekDay),
                      ),
                      const SizedBox(height: 24),
                      HoursPainel(
                          enableHours: openingHours,
                          startTime: 6,
                          endTime: 23,
                          onHoursPressed:
                              employeeRegisterVm.addOrRemoveWeekHours),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                        ),
                        onPressed: () {
                          switch (formKey.currentState?.validate()) {
                            case null || false:
                              Message.showErro(
                                  'Existe campos inválidos', context);
                            case true:
                              final EmployeeRegisterState(
                                :weekDays,
                                :weekHours
                              ) = ref.watch(employeeRegisterVmProvider);

                              if (weekDays.isEmpty || weekHours.isEmpty) {
                                Message.showErro(
                                    'Por favor, selecione os dias da semana e horários do atendimento',
                                    context);
                                return;
                              }

                              final String name = nameEC.text;
                              final String email = emailEC.text;
                              final String password = passwordEC.text;

                              employeeRegisterVm.register(
                                  name: name, email: email, password: password);
                          }
                        },
                        child: const Text('CADASTRAR COLABORADOR'),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
