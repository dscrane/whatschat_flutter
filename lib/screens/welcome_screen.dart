import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:whats_chat/constants.dart';
import 'package:whats_chat/screens/login_screen.dart';
import 'package:whats_chat/screens/registration_screen.dart';
import 'package:whats_chat/widgets/hero_logo.dart';
import 'package:whats_chat/widgets/rounded_button.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: <Widget>[
                  HeroLogo(),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'What\'s Chat',
                        textStyle: TextStyle(
                          shadows: [
                            Shadow(
                                blurRadius: 2.0,
                                color: kPrimaryDark,
                                offset: Offset.fromDirection(1.0))
                          ],
                          color: kPrimaryLight,
                          fontSize: 45.0,
                          fontWeight: FontWeight.w900,
                        ),
                        cursor: '|',
                        speed: const Duration(milliseconds: 250),
                      ),
                    ],
                    totalRepeatCount: 6,
                  ),
                ],
              ),
              SizedBox(height: 40.0),
              RoundedButton(
                title: 'Log In',
                color: kPrimary,
                handlePress: () {
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
