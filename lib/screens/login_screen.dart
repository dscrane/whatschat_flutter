import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
import 'package:whats_chat/constants.dart';
import 'package:whats_chat/screens/chat_list_screen.dart';
import 'package:whats_chat/widgets/authentication_text_field.dart';
import 'package:whats_chat/widgets/hero_logo.dart';
import 'package:whats_chat/widgets/rounded_button.dart';

// Future getData({username, password}) async {
//   print('getData() hit');
//   http.Response res = await http.post(
//     Uri.parse(
//       'http://localhost:5500/login-user',
//     ),
//     body: {username: username, password: password},
//     headers: {
//       'Access-Control-Allow-Origin': "http://localhost:5500/*",
//       'Content-Security-Policy': "default-src *",
//     },
//   );
//   print(res);
//   if (res.statusCode == 200) {
//     String data = res.body;
//     // return jsonDecode(data);
//   } else {
//     print(res.statusCode);
//   }
// }

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

  void handleLogin() async {
    Navigator.pop(context);
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
              SizedBox(height: 24.0),
              AuthenticationTextField(
                fieldType: 'email',
                handleChange: updateEmail,
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
