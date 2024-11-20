import 'package:barbearia_rb/src/core/ui/constant.dart';
import 'package:barbearia_rb/src/core/ui/widget/barbershop_icon.dart';
import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  final bool hideUploadButton;
  const AvatarWidget({super.key,  this.hideUploadButton = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 102,
      width: 102,
      child: Stack(
        children: [
          Container(
            height: 90,
            width: 90,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(ImageConstant.avatarImage))),
          ),
          Positioned(
              bottom: 2,
              right: 2,
              child: Offstage(
                 offstage: hideUploadButton,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorConstant.brow, width: 4),
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(
                    BarbershopIcon.addEmployee,
                    color: ColorConstant.brow,
                    size: 20,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
