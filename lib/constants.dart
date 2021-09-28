import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Stylistic constants
const kBackground = Color(0xFF42384f);
const kPrimary = Color(0xFF8741c1);
const kPrimaryLight = Color(0xFFba70f4);
const kPrimaryDark = Color(0xFF550d90);
const kSecondary = Color(0xFF44dae8);
const kSecondaryLight = Color(0xFF83ffff);
const kSecondaryDark = Color(0xFF00a8b6);
const kTextLightFaded = Color(0xFFB3ADAD);
const kTextLight = Color(0xFFFFFFFF);
const kTextDark = Color(0xFF000000);

const kChatListTitleStyle = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 18.0,
);

const kChatListMessageStyle = TextStyle(
  // fontWeight: FontWeight.w300,
  fontSize: 10.0,
  color: kTextLightFaded,
);
// Functional constants

// Data constants

// Icon constants
const CircleAvatar kUserAvatar = CircleAvatar(
  child: Icon(
    FontAwesomeIcons.user,
    size: 25.0,
    color: kSecondaryDark,
  ),
  backgroundColor: kTextLight,
  radius: 25.0,
);

const CircleAvatar kUsersAvatar = CircleAvatar(
  child: Icon(
    FontAwesomeIcons.userFriends,
    size: 25.0,
    color: kSecondaryDark,
  ),
  backgroundColor: kTextLight,
  radius: 25.0,
);

const Icon kMenuIcon = Icon(
  FontAwesomeIcons.ellipsisV,
  color: kSecondaryDark,
  size: 18.0,
);

const Icon kPlusIcon = Icon(
  FontAwesomeIcons.plus,
  color: kTextDark,
);

const Icon kMinusIcon = Icon(
  FontAwesomeIcons.minus,
  color: kTextLight,
);

const DummyData = [
  {
    '_id': '0001',
    'name': 'Buddies',
    'createdBy': '9991',
    'lastMessage': 'This was the last message!!',
  },
  {
    '_id': '0002',
    'name': 'Soccer',
    'createdBy': '9990',
    'lastMessage': 'Great game last week!!',
  },
  {
    '_id': '0003',
    'name': 'Welcome Room',
    'createdBy': '9999',
    'lastMessage': 'Welcome to WhatsChat!',
  }
];
