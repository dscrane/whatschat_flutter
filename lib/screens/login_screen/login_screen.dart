import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whats_chat/providers/session_model.dart';
import 'package:whats_chat/screens/chat_list_screen/chat_list_screen.dart';
import 'package:whats_chat/screens/welcome_screen/welcome_screen.dart';
import 'package:whats_chat/services/networking.dart';
import 'package:whats_chat/utils/constants.dart';
import 'package:whats_chat/widgets/authentication_text_field.dart';
import 'package:whats_chat/widgets/hero_logo.dart';
import 'package:whats_chat/widgets/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  String username = '';
  String password = '';

  void updateUsername(enteredUsername) => username = enteredUsername;

  void updatePassword(enteredPassword) => password = enteredPassword;

  void handleLogin() async {
    // Get instance of SharedPreferences
    final SharedPreferences prefs = await _prefs;
    try {
      // Query database for user with provided credentials
      Map<String, dynamic> response =
          await NetworkHelper.loginUser('mobiletester', 'mobiletestpass');

      // Update app state with newly logged in user details and token
      context.read<SessionModel>().handleUserLogin(response['user'], response['token']);

      // Update SharePreferences with authentication status and user data
      prefs.setBool('authenticated', true);
      prefs.setString('user', json.encode(context.read<SessionModel>().user));

      // Push to the ChatListScreen
      Navigator.pop(context);
      Navigator.pushNamed(context, ChatListScreen.id);
    } catch (e) {
      print(e);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(
            top: 10.0,
            left: 10.0,
            right: 10.0,
            bottom: 10.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              HeroLogo(),
              SizedBox(height: 100.0),
              Column(
                children: <Widget>[
                  AuthenticationTextField(
                    fieldType: 'email',
                    handleChange: updateUsername,
                    isRegistration: false,
                  ),
                  SizedBox(height: 24.0),
                  AuthenticationTextField(
                    fieldType: 'password',
                    handleChange: updatePassword,
                    isRegistration: false,
                  ),
                ],
              ),
              SizedBox(height: 70.0),
              Column(
                children: <Widget>[
                  RoundedButton(
                    title: 'Log In',
                    color: kPrimary,
                    handlePress: () {
                      handleLogin();
                    },
                  ),
                  RoundedButton(
                    title: 'Cancel',
                    color: kSecondary,
                    handlePress: () {
                      Navigator.pushNamed(context, WelcomeScreen.id);
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
