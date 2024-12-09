import 'package:barbearia_rb/src/core/ui/constant.dart';
import 'package:barbearia_rb/src/core/ui/widget/barbershop_icon.dart';
import 'package:barbearia_rb/src/model/user_model.dart';
import 'package:flutter/material.dart';

class EmployeeTile extends StatelessWidget {
  final UserModel employee;

  const EmployeeTile({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ColorConstant.grey),
      ),
      child: Row(
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: switch (employee.avatar) {
                  final avatar? => NetworkImage(avatar!),
                  _ => const AssetImage(ImageConstant.avatarImage),
                },
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  employee.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12)),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed('/schedule', arguments: employee);
                          },
                          child: const Text(
                            'AGENDAR',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12)),
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                '/employee/schedule',
                                arguments: employee);
                          },
                          child: const Text(
                            'VER AGENDA',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          )),
                      const Icon(
                        BarbershopIcon.penEdit,
                        color: ColorConstant.brow,
                        size: 18,
                      ),
                      const Icon(
                        BarbershopIcon.trash,
                        color: ColorConstant.red,
                        size: 18,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
