import 'package:comet/screens/chatpage.dart';
import 'package:comet/screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';


class BottomNavigationBarPage extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeNotifier;
  const BottomNavigationBarPage({super.key,required this.themeNotifier});

  @override
  State<BottomNavigationBarPage> createState() => _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  int myIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: const TextStyle(color: Vx.white),
          showUnselectedLabels: true,
          showSelectedLabels: true,
          selectedItemColor: Vx.white,
          unselectedItemColor: Vx.gray500,
          backgroundColor: Vx.black,
          type: BottomNavigationBarType.fixed,
          elevation: 50,
          iconSize: 26,
          currentIndex: myIndex,
          onTap: (index) {
            setState(() {
              myIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                myIndex == 0 ?CupertinoIcons.chat_bubble_2_fill:CupertinoIcons.chat_bubble_2,
                color: myIndex == 0 ? Vx.white : Vx.gray500,
              ),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                myIndex == 1 ?CupertinoIcons.gear_alt_fill:CupertinoIcons.gear_alt,
                color: myIndex == 1 ? Vx.white : Vx.gray500,
              ),
              label: 'Settings',
            ),
          ],
        ),
        body: IndexedStack(
          index: myIndex,
          children: [
            Builder(builder: (context) {
              return const ChatPage(
                recieverUserName: 'Comet',
                recieverID: 'user123',
                recieverEmail: 'john@example.com',
              );
            }),
            SettingsPage(themeNotifier: widget.themeNotifier,),
          ],
        ),
      ),
    );
  }
}