import 'package:barbearia_rb/src/core/ui/message.dart';
import 'package:barbearia_rb/src/core/ui/widget/hours_painel.dart';
import 'package:barbearia_rb/src/core/ui/widget/weekdays_painel.dart';
import 'package:barbearia_rb/src/feature/auth/register/barbershop/barbershop_register_state.dart';
import 'package:barbearia_rb/src/feature/auth/register/barbershop/barbershop_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class BarbershopRegisterPage extends ConsumerStatefulWidget {
  const BarbershopRegisterPage({super.key});

  @override
  ConsumerState<BarbershopRegisterPage> createState() =>
      _BarbershopRegisterPageState();
}

class _BarbershopRegisterPageState
    extends ConsumerState<BarbershopRegisterPage> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final emailEC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final barbershopRegisterVm =
        ref.watch(barbershopRegisterVmProvider.notifier);

    ref.listen(barbershopRegisterVmProvider, (_, state) {
      switch (state.status) {
        case BarbershopRegisterStateStatus.initial:
          break;
        case BarbershopRegisterStateStatus.error:
        Message.showErro('Desculpe não foi possível registar a barbearia', context);
        case BarbershopRegisterStateStatus.sucess:
        Navigator.of(context).pushNamedAndRemoveUntil( '/home/adm', (route) => false);
        Message.showSucess('Barbearia registrada com sucesso', context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar estabelecimento'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  controller: nameEC,
                  validator: Validatorless.required('Nome obrigatório'),
                  decoration: const InputDecoration(label: Text("Nome")),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: emailEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('E-mail obrigatório'),
                    Validatorless.email('E-mail inválido')
                  ]),
                  decoration: const InputDecoration(label: Text("E-mail")),
                ),
                const SizedBox(height: 24),
                WeekdaysPainel(
                  onDayPressed: (String value) {
                    barbershopRegisterVm.addOrRemoveOpenDay(value);
                  },
                ),
                const SizedBox(height: 24),
                HoursPainel(
                  startTime: 6,
                  endTime: 23,
                  onHoursPressed: (int value) {
                    barbershopRegisterVm.addOrRemoveOpenHours(value);
                  },
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                  onPressed: () {
                    switch (formKey.currentState?.validate()) {
                      case null || false:
                        Message.showErro('Formulário inválido', context);
                      case true:
                        barbershopRegisterVm.register(
                            nameEC.text, 
                            emailEC.text
                          );
                    }
                  },
                  child: const Text('CADASTRAR ESTABELECIMENTO'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
