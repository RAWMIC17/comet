import 'package:comet/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class MyTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;

  const MyTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    // Set colors based on the theme
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final borderColor =
        isDarkMode ? Vx.blue400 : Vx.green400;
    final fillColor = isDarkMode ? Colors.grey.shade800 : Colors.grey.shade200;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Theme(data: ThemeData(textSelectionTheme: TextSelectionThemeData(selectionColor: Vx.blue200,selectionHandleColor: Vx.blue500)),
        child: TextField(
          cursorColor: Vx.blue500,
          controller: controller,
          obscureText: obscureText,
          style: TextStyle(color: textColor,fontWeight: FontWeight.w400), // Dynamic text color
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor), // Dynamic border color
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: borderColor),
            ),
            fillColor: fillColor, // Dynamic fill color
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500]),
            suffixIcon: suffixIcon,
          ),
        ),
      ),
    );
  }
}
