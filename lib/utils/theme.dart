import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MyTheme {
  static ThemeData darktheme(BuildContext context) => ThemeData(
        primaryColor: Vx.white,
        primaryTextTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white),),
        hintColor: Vx.gray300,
        //scaffoldBackgroundColor: Vx.gray800,
        iconButtonTheme: const IconButtonThemeData(
          style: ButtonStyle(iconColor: WidgetStatePropertyAll(Vx.black)),
        ),
        inputDecorationTheme: InputDecorationTheme(
          counterStyle: const TextStyle(color: Vx.white),
          hintStyle: const TextStyle(
            color: Vx.gray500,
            fontWeight: FontWeight.w300,
            wordSpacing: 2,
          ),
          labelStyle: const TextStyle(color: Vx.white),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(60)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(60)),
            borderSide: BorderSide(color: Vx.blue400),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(60.0), 
            borderSide: const BorderSide(color: Vx.green400, width: 2.0),
          ),
          errorStyle: const TextStyle(color: Vx.red400), 
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Vx.white, 
        ),
      );
}
