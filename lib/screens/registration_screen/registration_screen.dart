import 'package:flutter/material.dart';
import 'package:whats_chat/constants.dart';
import 'package:whats_chat/screens/chat_list_screen/chat_list_screen.dart';
import 'package:whats_chat/widgets/authentication_text_field.dart';
import 'package:whats_chat/widgets/hero_logo.dart';
import 'package:whats_chat/screens/chat_screen/widgets/rounded_button.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late String email;
  late String password;
  late String passwordConfirmation;
  late String username;

  String? initEmail;
  String? initUsername;

  void handleRegistration() {
    if (password == passwordConfirmation) {
      print({
        "username": username,
        "email": email,
        "password": password,
      });
      Navigator.pushNamed(context, ChatListScreen.id);
    } else {
      // Pass in the correct input data for registration form after mismatched passwords
      setState(() {
        initEmail = email;
        initUsername = username;
      });
      print('Passwords did not match');
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
              kBoxMd,
              Text('Register your account!', style: kRegistrationTitleStyle),
              kBoxMd,
              AuthenticationTextField(
                initialValue: initUsername,
                fieldType: 'username',
                handleChange: (value) => username = value,
              ),
              kBoxMd,
              AuthenticationTextField(
                initialValue: initEmail,
                fieldType: 'email',
                handleChange: (value) => email = value,
              ),
              kBoxMd,
              AuthenticationTextField(
                fieldType: 'password',
                handleChange: (value) => password = value,
              ),
              kBoxMd,
              AuthenticationTextField(
                fieldType: 'password-confirm',
                handleChange: (value) => passwordConfirmation = value,
              ),
              kBoxMd,
              RoundedButton(
                title: 'Register',
                color: kSecondary,
                handlePress: () {
                  handleRegistration();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
