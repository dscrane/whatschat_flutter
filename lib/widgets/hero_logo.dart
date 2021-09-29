import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:whats_chat/constants.dart';

class HeroLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: ShaderMask(
        shaderCallback: (Rect bounds) {
          return RadialGradient(
            center: Alignment.bottomCenter,
            radius: .65,
            colors: [
              kPrimaryAccent,
              kSecondaryAccent,
            ],
          ).createShader(bounds);
        },
        child: Hero(
          tag: 'logo',
          child: Container(
            child: Icon(
              FontAwesomeIcons.fire,
              size: 60.0,
            ),
            height: 65.0,
          ),
        ),
      ),
    );
  }
}
