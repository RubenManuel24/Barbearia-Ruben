import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../constant.dart';

class BabershopLoader extends StatelessWidget {
  const BabershopLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.threeArchedCircle(
          color: ColorConstant.brow, size: 50),
    );
  }
}
