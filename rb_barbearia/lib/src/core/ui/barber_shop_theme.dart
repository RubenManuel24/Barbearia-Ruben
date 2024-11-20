import 'package:barbearia_rb/src/core/ui/constant.dart';
import 'package:flutter/material.dart';

sealed class BarberShopTheme {
  static const _defaultInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
      borderSide: BorderSide(color: ColorConstant.grey));

  static ThemeData themeData = ThemeData(
      useMaterial3: true,
      appBarTheme:  const AppBarTheme(
        iconTheme: IconThemeData(color: ColorConstant.brow),
        titleTextStyle: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontFamily: FontConstant.FontFamilyText),
        centerTitle: true,
      ),
      inputDecorationTheme: InputDecorationTheme(
          labelStyle: const TextStyle(color: ColorConstant.grey),
          fillColor: Colors.white,
          filled: true,
          border: _defaultInputBorder,
          focusedBorder: _defaultInputBorder,
          enabledBorder: _defaultInputBorder,
          errorBorder: _defaultInputBorder.copyWith(
              borderSide: const BorderSide(color: ColorConstant.red))),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorConstant.brow,
          foregroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ElevatedButton.styleFrom(
         shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)
         ),
         side:const BorderSide(color: ColorConstant.brow, width: 2),
          foregroundColor: ColorConstant.brow
        )
      ),
      fontFamily: FontConstant.FontFamilyText);
}
