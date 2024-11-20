import 'package:flutter/material.dart';

class BarbershopNavGlobaKey {
  static BarbershopNavGlobaKey? _instance;
  
  final navKey = GlobalKey<NavigatorState>();

  BarbershopNavGlobaKey._();
  static BarbershopNavGlobaKey get instance =>
    _instance ??= BarbershopNavGlobaKey._();
}