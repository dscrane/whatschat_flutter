import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_chat/constants.dart';
import 'package:whats_chat/providers/session_provider.dart';
import 'package:whats_chat/screens/chat_list_screen/chat_list_screen.dart';
import 'package:whats_chat/screens/chat_screen/chat_screen.dart';
import 'package:whats_chat/screens/login_screen/login_screen.dart';
import 'package:whats_chat/screens/profile_screen/profile_screen.dart';
import 'package:whats_chat/screens/registration_screen/registration_screen.dart';
import 'package:whats_chat/screens/settings_screen/settings_screen.dart';
import 'package:whats_chat/screens/welcome_screen/welcome_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => SessionProvider()),
    ],
    child: MyApp(),
  ));
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
