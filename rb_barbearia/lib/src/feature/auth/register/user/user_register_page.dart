import 'package:barbearia_rb/src/core/ui/helpers/form_helpers.dart';
import 'package:barbearia_rb/src/core/ui/message.dart';
import 'package:barbearia_rb/src/feature/auth/register/user/user_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class UserRegisterPage extends ConsumerStatefulWidget {
  const UserRegisterPage({super.key});

  @override
  ConsumerState<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends ConsumerState<UserRegisterPage> {
  final formKey = GlobalKey<FormState>();

  final nameEC = TextEditingController(text: 'Teste1');
  final emailEC = TextEditingController(text: 'teste@gmail.com');
  final passwordEC = TextEditingController(text: '123456789');

  @override
  void dispose() {
    nameEC.dispose();
    emailEC.dispose();
    passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userRegisterVN = ref.watch(userRegisterVmProvider.notifier);

    ref.listen(userRegisterVmProvider, (_, state) {
      switch (state) {
        case UserRegisterStateStatus.initial:
         break;
        case UserRegisterStateStatus.sucess:
        Navigator.of(context).pushNamedAndRemoveUntil('/auth/register/barbershop', (route) => false);
        Message.showSucess('Administrador registado com sucesso', context);
        case UserRegisterStateStatus.error:
        Message.showErro('Erro ao tentar registar administrador', context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  onTapOutside: (_) => unFocus(context),
                  controller: nameEC,
                  validator: Validatorless.required('Nome inválido'),
                  decoration: const InputDecoration(label: Text('Name')),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: emailEC,
                  onTapOutside: (_) => unFocus(context),
                  validator: Validatorless.multiple([
                    Validatorless.required('E-mail obrigatório'),
                    Validatorless.email('E-mail inválido')
                  ]),
                  decoration: const InputDecoration(label: Text('E-mail')),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: passwordEC,
                  onTapOutside: (_) => unFocus(context),
                  validator: Validatorless.multiple([
                    Validatorless.required('Senha obrigatório'),
                    Validatorless.min(
                        6, 'Senha deve ter no mínimo 6 caracteres')
                  ]),
                  decoration: const InputDecoration(label: Text('Senha')),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  onTapOutside: (_) => unFocus(context),
                  validator: Validatorless.multiple([
                    Validatorless.required('Confirma Senha obrigatório'),
                    Validatorless.compare(
                        passwordEC, 'Senha Confirma diferente do Senha')
                  ]),
                  decoration:
                      const InputDecoration(label: Text('Confirmar Senha')),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(56)),
                    onPressed: () {
                      switch (formKey.currentState?.validate()) {
                        case null || false:
                          Message.showErro('Formulário Inválido', context);
                        case true:
                          userRegisterVN.userRegister(
                              name: nameEC.text,
                              email: emailEC.text,
                              password: passwordEC.text);
                      }
                    },
                    child: const Text('CRIAR CONTA'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
