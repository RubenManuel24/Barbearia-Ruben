import 'package:barbearia_rb/src/core/providers/application_providers.dart';
import 'package:barbearia_rb/src/core/ui/constant.dart';
import 'package:barbearia_rb/src/core/ui/widget/babershop_loader.dart';
import 'package:barbearia_rb/src/core/ui/widget/barbershop_icon.dart';
import 'package:barbearia_rb/src/feature/home/adm/home_adm_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeHeader extends ConsumerWidget {
  final bool hideFilter;
  const HomeHeader({super.key, this.hideFilter = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final barbershop = ref.watch(getMyBarbershopProvider);

    return SafeArea(
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(24),
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)),
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage(
              ImageConstant.backGroundChair,
            ),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            barbershop.maybeWhen(
              orElse: () {
                return const Center(
                  child: BabershopLoader(),
                );
              },
             
             data: (barbershopData){

              return  Row(
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xffbdbdbd),
                  child: SizedBox.shrink(),
                ),
                const SizedBox(width: 16),
                 Flexible(
                  child: Text(
                   barbershopData.name,
                    style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    child: const Text(
                      'editar',
                      style: TextStyle(
                          color: ColorConstant.brow,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    ref.read(homeAdmVmProvider.notifier).logout();
                  },
                  icon: const Icon(
                    BarbershopIcon.exit,
                    color: ColorConstant.brow,
                    size: 32,
                  ),
                )
              ],
            );

             }


            ),
           
            const SizedBox(height: 24),
            const Text(
              'Bem Vindo',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 24),
            const Text(
              'Agende um Cliente',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w600),
            ),
            Offstage(offstage: hideFilter, child: const SizedBox(height: 24)),
            Offstage(
              offstage: hideFilter,
              child: TextFormField(
                decoration: const InputDecoration(
                  label: Text('Buscar colaborador'),
                  suffixIcon: Padding(
                    padding: EdgeInsets.only(right: 24),
                    child: Icon(
                      size: 26,
                      BarbershopIcon.search,
                      color: ColorConstant.brow,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
