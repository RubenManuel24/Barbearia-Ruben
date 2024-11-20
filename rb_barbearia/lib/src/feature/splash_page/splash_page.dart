import 'dart:developer';

import 'package:barbearia_rb/src/core/ui/constant.dart';
import 'package:barbearia_rb/src/core/ui/message.dart';
import 'package:barbearia_rb/src/feature/auth/login/login_page.dart';
import 'package:barbearia_rb/src/feature/auth/register/barbershop/barbershop_register_page.dart';
import 'package:barbearia_rb/src/feature/splash_page/splash_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  var _scale = 10.0;
  var _animationOpacityLogo = 0.0;

  double get _animationOpacityLogoWidth => 110 * _scale;
  double get _animationOpacityLogoHeight => 120 * _scale;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _scale = 1;
        _animationOpacityLogo = 1.0;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(splashVmProvider, (_, state) {
      state.whenOrNull(error: (error, stackTrace) {
        log('Erro ao validar o login', error: error, stackTrace: stackTrace);
        Message.showErro('Erro ao validar o login', context);
        Navigator.of(context).pushNamedAndRemoveUntil('/auth/login', (route) => false);
      }, data: (data) {
        switch (data) {
          case SplashState.loggedADM:
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/home/adm', (route) => false);
          case SplashState.loggedEmployee:
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/home/employee', (route) => false);
          case _:
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/auth/login', (route) => false);
        }
      });
    });

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              opacity: 0.2,
              fit: BoxFit.cover,
              image: AssetImage(
                ImageConstant.backGroundChair,
              ),
            ),
          ),
          child: Center(
            child: AnimatedOpacity(
              duration: const Duration(seconds: 1),
              opacity: _animationOpacityLogo,
              curve: Curves.easeIn,
              child: AnimatedContainer(
                duration: const Duration(seconds: 1),
                curve: Curves.linearToEaseOut,
                width: _animationOpacityLogoWidth,
                height: _animationOpacityLogoHeight,
                child: Image.asset(
                  ImageConstant.imageLogo,
                  fit: BoxFit.cover,
                ),
              ),
              onEnd: () {
                Navigator.of(context).pushAndRemoveUntil(
                    PageRouteBuilder(
                        settings: const RouteSettings(name: '/auth/login'),
                        //settings: const RouteSettings(name: '/auth/register/barbershop'),
                        pageBuilder: (context, animation, child) {
                          return const LoginPage();
                          //return const BarbershopRegisterPage();
                        },
                        transitionsBuilder: (_, animation, __, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        }),
                    (route) => false);
              },
            ),
          ),
        ));
  }
}
