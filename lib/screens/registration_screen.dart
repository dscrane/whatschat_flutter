import 'package:flutter/material.dart';
import 'package:whats_chat/constants.dart';
import 'package:whats_chat/screens/chat_list_screen.dart';
import 'package:whats_chat/widgets/authentication_text_field.dart';
import 'package:whats_chat/widgets/hero_logo.dart';
import 'package:whats_chat/widgets/rounded_button.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email = '';
  String password = '';

  void updateEmail(enteredEmail) {
    print(enteredEmail);
    email = enteredEmail;
  }

  void updatePassword(enteredPassword) {
    print(enteredPassword);
    password = enteredPassword;
  }

  void updateUsername(enteredUsername) {
    print(enteredUsername);
    password = enteredUsername;
  }

  void handleRegistration() {
    Navigator.pushNamed(context, ChatListScreen.id);
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
                fieldType: 'username',
                handleChange: updateUsername,
              ),
              kBoxMd,
              AuthenticationTextField(
                fieldType: 'email',
                handleChange: updateEmail,
              ),
              kBoxMd,
              AuthenticationTextField(
                fieldType: 'password',
                handleChange: updatePassword,
              ),
              kBoxMd,
              AuthenticationTextField(
                fieldType: 'password-confirm',
                handleChange: updatePassword,
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
