import 'package:barbearia_rb/src/core/ui/barber_shop_theme.dart';
import 'package:barbearia_rb/src/core/ui/barbershop_nav_globa_key.dart';
import 'package:barbearia_rb/src/feature/auth/login/login_page.dart';
import 'package:barbearia_rb/src/feature/auth/register/user/user_register_page.dart';
import 'package:barbearia_rb/src/feature/employee/register/employee_register_page.dart';
import 'package:barbearia_rb/src/feature/employee/schedule/employee_schedule_page.dart';
import 'package:barbearia_rb/src/feature/home/adm/home_adm_page.dart';
import 'package:barbearia_rb/src/feature/schedule/schedule_page.dart';
import 'package:barbearia_rb/src/feature/splash_page/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:asyncstate/asyncstate.dart';
import 'core/ui/widget/babershop_loader.dart';
import 'feature/auth/register/barbershop/barbershop_register_page.dart';

class BarbershopApp extends StatelessWidget {
  const BarbershopApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncStateBuilder(
        customLoader: const BabershopLoader(),
        builder: (ansycNavigatorObserver) {
          return MaterialApp(
            theme: BarberShopTheme.themeData,
            title: 'Barbearia Rudev',
            navigatorObservers: [ansycNavigatorObserver],
            navigatorKey: BarbershopNavGlobaKey.instance.navKey,
            routes: {
              '/': (_) => const SplashPage(),
              '/auth/login': (_) => const LoginPage(),
              '/auth/register/user': (_) => const UserRegisterPage(),
              '/auth/register/barbershop': (_) => const BarbershopRegisterPage(),
              '/home/adm': (_) => const HomeAdmPage(),
              '/employee/register': (_) => const EmployeeRegisterPage(),
              '/employee/schedule': (_) => const EmployeeSchedulePage(),
              '/schedule': (_) => const SchedulePage()
            },
          );
        });
  }
}
