import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class SettingsPage extends StatefulWidget {
  final ValueNotifier<ThemeMode> themeNotifier; // Add this parameter

  const SettingsPage({Key? key, required this.themeNotifier}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final user = FirebaseAuth.instance.currentUser!;

  // Sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 10,
        shadowColor:  Vx.black,
        title: Text('Settings'),
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Logged in as ${user.email}',
              style: TextStyle(fontSize: 19),
            ),
            SizedBox(height: 20),
            Text('Toggle Theme'),
            ValueListenableBuilder<ThemeMode>(
              valueListenable: widget.themeNotifier,
              builder: (context, themeMode, child) {
                return Switch(
                  activeColor: Vx.blue300,
                  value: themeMode == ThemeMode.dark,
                  onChanged: (value) {
                    // Change the theme mode based on the switch value
                    widget.themeNotifier.value =
                        value ? ThemeMode.dark : ThemeMode.light;
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}