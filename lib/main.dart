import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whats_chat/providers/chat_model.dart';
import 'package:whats_chat/providers/session_model.dart';
import 'package:whats_chat/providers/settings_model.dart';
import 'package:whats_chat/screens/chat_list_screen/chat_list_screen.dart';
import 'package:whats_chat/screens/chat_screen/chat_screen.dart';
import 'package:whats_chat/screens/login_screen/login_screen.dart';
import 'package:whats_chat/screens/profile_screen/profile_screen.dart';
import 'package:whats_chat/screens/registration_screen/registration_screen.dart';
import 'package:whats_chat/screens/settings_screen/settings_screen.dart';
import 'package:whats_chat/screens/welcome_screen/welcome_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SessionModel>(create: (_) => SessionModel()),
        ChangeNotifierProvider<SettingsModel>(create: (_) => SettingsModel()),
        ChangeNotifierProvider<ChatsModel>(create: (_) => ChatsModel()),
      ],
      child: Phoenix(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    backgroundColor: Color(0xff1A1B2F),
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.dark,
      primaryColorDark: Color(0xff8741c1),
      accentColor: Color(0xff71f5f5),
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.red /* Color(0xFFFFFFFF)*/),
      bodyText2: TextStyle(
        color: Color(0xFFFFFFFF),
        fontWeight: FontWeight.w700,
        fontSize: 18.0,
      ),
      subtitle1: TextStyle(color: Color(0xFF9793A4), fontSize: 14.0),
      subtitle2: TextStyle(color: Colors.red),
    ),
    iconTheme: IconThemeData(
      color: Color(0xff71f5f5),
    ),
  );
  ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    backgroundColor: Color(0xffb8b2d9),
    colorScheme: ColorScheme.fromSwatch(
      brightness: Brightness.light,
      primaryColorDark: Color(0xffb58ed9),
      accentColor: Color(0xff337c85),
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(color: Colors.red /* Color(0xFFFFFFFF)*/),
      bodyText2: TextStyle(
        color: Color(0xFF000000),
        fontWeight: FontWeight.w700,
        fontSize: 18.0,
      ),
      subtitle1: TextStyle(color: Color(0xFF424148), fontSize: 14.0),
      subtitle2: TextStyle(color: Colors.red),
    ),
    iconTheme: IconThemeData(
      color: Color(0xff337c85),
    ),
  );

  @override
  void initState() {
    _prefs.then((SharedPreferences prefs) {
      print('prefs from main');
      inspect(prefs);
      context.read<SessionModel>().authenticated = prefs.getBool('authenticated') ?? false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WhatsChat',
      theme: context.watch<SessionModel>().darkTheme ? darkTheme : lightTheme,
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
