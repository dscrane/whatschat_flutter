import 'dart:convert';
import 'dart:developer';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:whats_chat/constants.dart';
import 'package:whats_chat/models/user.dart';
import 'package:whats_chat/providers/session_model.dart';
import 'package:whats_chat/screens/chat_list_screen/chat_list_screen.dart';
import 'package:whats_chat/screens/login_screen/login_screen.dart';
import 'package:whats_chat/screens/registration_screen/registration_screen.dart';
import 'package:whats_chat/utils/log.dart';
import 'package:whats_chat/widgets/hero_logo.dart';
import 'package:whats_chat/widgets/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
// todo: check for authorized token in shared_preferences
  //  if there is a token skip login screen
  // if not hit login screen like normal
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  Widget build(BuildContext context) {
    _prefs.then((SharedPreferences prefs) {
      inspect(prefs);
    });
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  HeroLogo(),
                  AnimatedTitle(),
                ],
              ),
              SizedBox(height: 40.0),
              RoundedButton(
                title: 'Log In',
                color: kPrimary,
                handlePress: () {
                  if (context.read<SessionModel>().authenticated) {
                    context.read<SessionModel>().prefs.then((SharedPreferences prefs) {
                      String savedUser = prefs.getString('user') as String;
                      context.read<SessionModel>().user =
                          User.fromPreferences(json.decode(savedUser));
                    });
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      ChatListScreen.id,
                      ModalRoute.withName(WelcomeScreen.id),
                    );
                    return;
                  }
                  Navigator.pushNamed(context, LoginScreen.id);
                },
              ),
              RoundedButton(
                title: 'Register',
                color: kSecondary,
                handlePress: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedTitle extends StatelessWidget {
  const AnimatedTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(
          'What\'s Chat',
          textStyle: TextStyle(
            shadows: [
              Shadow(
                blurRadius: 2.0,
                color: kPrimaryDark,
                offset: Offset.fromDirection(1.0),
              ),
            ],
            color: kTextLight,
            fontSize: 45.0,
            fontWeight: FontWeight.w900,
          ),
          cursor: '|',
          speed: const Duration(milliseconds: 175),
        ),
      ],
      totalRepeatCount: 6,
    );
  }
}
