import 'package:barbearia_rb/src/core/ui/constant.dart';
import 'package:barbearia_rb/src/core/ui/helpers/form_helpers.dart';
import 'package:barbearia_rb/src/core/ui/message.dart';
import 'package:barbearia_rb/src/feature/auth/login/login_state.dart';
import 'package:barbearia_rb/src/feature/auth/login/login_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final formKey = GlobalKey<FormState>();

  final emailEC = TextEditingController(text: 'rodrigorahman1@gmail.com');
  final passwordEc = TextEditingController(text: '123123');

  @override
  void dispose() {
    emailEC.dispose();
    passwordEc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginVm(:login) = ref.watch(loginVmProvider.notifier);

    ref.listen(loginVmProvider, (_, state) {
      switch (state) {
        case LoginState(status: LoginStateStatus.initial):
          break;
        case LoginState(status: LoginStateStatus.error, :final errorMessage?):
          Message.showErro(errorMessage, context);
        case LoginState(status: LoginStateStatus.error):
          Message.showErro('Erro ao fazer login', context);
        case LoginState(status: LoginStateStatus.admLogin):
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home/adm', (route) => false);
               Message.showSucess('Login feito com sucesso', context);
        case LoginState(status: LoginStateStatus.empleyeeLogin):
          Navigator.of(context)
              .pushNamedAndRemoveUntil('/home/employee', (route) => false);
               Message.showSucess('Login feito com sucess', context);
      }
    });

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Form(
        key: formKey,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              opacity: 0.2,
              fit: BoxFit.cover,
              image: AssetImage(
                ImageConstant.backGroundChair,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageConstant.imageLogo,
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            onTapOutside: (_) => unFocus(context),
                            controller: emailEC,
                            validator: Validatorless.multiple([
                              Validatorless.required('E-Mail obrigatório'),
                              Validatorless.email('E-Mail inválido')
                            ]),
                            decoration: const InputDecoration(
                                labelText: 'E-mail',
                                hintText: 'Email',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                hintStyle: TextStyle(color: Colors.black),
                                labelStyle: TextStyle(color: Colors.black)),
                          ),
                          const SizedBox(height: 24),
                          TextFormField(
                            controller: passwordEc,
                            obscureText: true,
                            onTapOutside: (_) => unFocus(context),
                            validator: Validatorless.multiple([
                              Validatorless.required('Senha é obrigatório'),
                              Validatorless.min(6,
                                  'A senha tem que ter no mínimo 6 caracteres')
                            ]),
                            decoration: const InputDecoration(
                                labelText: 'Senha',
                                hintText: 'Senha',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                hintStyle: TextStyle(color: Colors.black),
                                labelStyle: TextStyle(color: Colors.black)),
                          ),
                          const SizedBox(height: 24),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Esqueceu a senha?',
                              style: TextStyle(
                                  color: ColorConstant.brow, fontSize: 12),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: const Size.fromHeight(56)),
                              onPressed: () {
                                switch (formKey.currentState!.validate()) {
                                  case null || false:
                                    Message.showErro(
                                        'Campos inválidos', context);
                                  case true:
                                    login(emailEC.text, passwordEc.text);
                                }
                              },
                              child: const Text('ACESSAR')),
                        ],
                      ),
                       Positioned(
                        bottom: 50,
                         child: Align(
                              alignment: Alignment.bottomCenter,
                              child: InkWell(
                                onTap: (){
                                 Navigator.of(context).pushNamed('/auth/register/user');
                                 //Navigator.of(context).pushNamed('/employee/register');
                                },
                                child: const Text(
                                  'Criar conta',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                       )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
