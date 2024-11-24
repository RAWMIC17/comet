import 'package:comet/screens/navbarpage.dart';
import 'package:comet/utils/theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MyTheme.darktheme(context),
      debugShowCheckedModeBanner: false,
       home:const BottomNavigationBarPage()
    );
  }
}
