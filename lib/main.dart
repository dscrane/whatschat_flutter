import 'package:flutter/material.dart';
import 'package:whats_chat/constants.dart';
import 'package:whats_chat/screens/chat_list_screen.dart';
import 'package:whats_chat/screens/chat_screen.dart';
import 'package:whats_chat/screens/login_screen.dart';
import 'package:whats_chat/screens/profile_screen.dart';
import 'package:whats_chat/screens/registration_screen.dart';
import 'package:whats_chat/screens/settings_screen.dart';
import 'package:whats_chat/screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WhatsChat',
      theme: ThemeData(
        backgroundColor: kBackground,
        brightness: Brightness.dark,
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ChatListScreen.id: (context) => ChatListScreen(),
        ChatScreen.id: (context) => ChatScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        SettingsScreen.id: (context) => SettingsScreen(),
      },
    );
  }
}
