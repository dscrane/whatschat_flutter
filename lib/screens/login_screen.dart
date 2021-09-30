import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:whats_chat/constants.dart';
import 'package:whats_chat/models/user.dart';
import 'package:whats_chat/screens/chat_list_screen.dart';
import 'package:whats_chat/widgets/authentication_text_field.dart';
import 'package:whats_chat/widgets/hero_logo.dart';
import 'package:whats_chat/widgets/rounded_button.dart';
import 'package:whats_chat/services/networking.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';

  void updateUsername(enteredUsername) {
    print(enteredUsername);
    username = enteredUsername;
  }

  void updatePassword(enteredPassword) {
    print(enteredPassword);
    password = enteredPassword;
  }

  void handleLogin() async {
    var user = await NetworkHelper.loginUser('sampleuser', 'examplepass000');
    if (user != null) {
      print(user);
      User userData = User.fromJsoN(user);
      print(userData);
      print(userData.runtimeType);
      Navigator.pop(context);
      Navigator.pushNamed(context, ChatListScreen.id);
    } else {
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
              SizedBox(height: 24.0),
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
              SizedBox(height: 24.0),
              RoundedButton(
                title: 'Log In',
                color: kPrimary,
                handlePress: () {
                  handleLogin();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
