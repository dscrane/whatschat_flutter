import 'package:flutter/material.dart';
import 'package:whats_chat/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeroLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: Hero(
        tag: 'logo',
        child: Container(
          child: Icon(
            FontAwesomeIcons.fire,
            color: kDeepPurple,
            size: 60.0,
          ),
          height: 60.0,
        ),
      ),
    );
  }
}
