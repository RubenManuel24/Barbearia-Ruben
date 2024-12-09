import 'dart:developer';

import 'package:barbearia_rb/src/core/providers/application_providers.dart';
import 'package:barbearia_rb/src/core/ui/constant.dart';
import 'package:barbearia_rb/src/core/ui/widget/babershop_loader.dart';
import 'package:barbearia_rb/src/core/ui/widget/barbershop_icon.dart';
import 'package:barbearia_rb/src/feature/home/adm/home_adm_state.dart';
import 'package:barbearia_rb/src/feature/home/adm/home_adm_vm.dart';
import 'package:barbearia_rb/src/feature/home/adm/widget/employee_tile.dart';
import 'package:barbearia_rb/src/feature/home/widget/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeAdmPage extends ConsumerWidget {
  const HomeAdmPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final homeState = ref.watch(homeAdmVmProvider);

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: ColorConstant.brow,
          shape: const CircleBorder(),
          onPressed: () async {
            await Navigator.of(context).pushNamed('/employee/register');
            ref.invalidate(getMeProvider);
            ref.invalidate(homeAdmVmProvider);
          },
          child: const CircleAvatar(
            maxRadius: 16,
            backgroundColor: Colors.white,
            child: Icon(
              BarbershopIcon.addEmployee,
              color: ColorConstant.brow,
            ),
          ),
        ),
        body: homeState.when(
            data: (HomeAdmState data) {
              return CustomScrollView(
                slivers: [
                  const SliverToBoxAdapter(
                    child: HomeHeader(),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (context, index) =>  EmployeeTile(employee: data.employee[index],),
                        childCount: data.employee.length
                       
                      ),
                  )
                ],
              );
            },
            error: (Object e, StackTrace s) {
              log('Erro ao carregar colaboradores', error: e, stackTrace: s);
              return const Center(child: Text('Erro ao carregar página'),);
              
            },
            loading: () {
              return const Center(child: BabershopLoader(),);
            }));
  }
}
