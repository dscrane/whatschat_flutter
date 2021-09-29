import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// Box constants
const kBoxSm = SizedBox(height: 16.0);
const kBoxMd = SizedBox(height: 24.0);
const kBoxLg = SizedBox(height: 32.0);
const kBoxXl = SizedBox(height: 48.0);

// Color scheme constants
const kBackground = Color(0xff48424e);
const kPrimary = Color(0xFF8741c1);
const kPrimaryLight = Color(0xFFba70f4);
const kPrimaryDark = Color(0xff4a107c);
const kDeepPurple = Color(0xff2e094c);
const kSecondary = Color(0xFF44dae8);
const kSecondaryLight = Color(0xFF83ffff);
const kSecondaryDark = Color(0xFF00a8b6);
const kTextLightFaded = Color(0xFF9793A4);
const kTextLight = Color(0xFFFFFFFF);
const kTextDark = Color(0xFF000000);

// Stylistic constants
const kChatListTitleStyle = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 18.0,
);

const kChatListMessageStyle = TextStyle(
  fontSize: 14.0,
  color: kTextLightFaded,
);

const kRegistrationTitleStyle = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.w700,
  color: kTextLight,
);

const kTextFieldDecoration = InputDecoration(
    hintStyle: TextStyle(
      color: kTextLightFaded,
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kPrimaryDark, width: 1.5),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kDeepPurple, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ));
// Functional constants

// Icon constants
const CircleAvatar kUserAvatar = CircleAvatar(
  child: Icon(
    FontAwesomeIcons.user,
    size: 20.0,
    color: kSecondaryDark,
  ),
  backgroundColor: kTextLight,
  radius: 20.0,
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
  color: kDeepPurple,
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

const Icon kSearchIcon = Icon(
  FontAwesomeIcons.search,
  color: kTextLight,
);

// Data constants
const kChatListMenuValues = [];

const DummyChats = [
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

const DummyMessages = {
  "0001": [
    {"author": "user1", "message": "Message 1"},
    {"author": "user2", "message": "Message 2"},
    {"author": "user1", "message": "Message 3"},
    {"author": "user2", "message": "Message 4"},
  ],
  "0002": [
    {"author": "tester1", "message": "Soccer 1"},
    {"author": "tester2", "message": "Soccer 2"},
    {"author": "tester1", "message": "Soccer 3"},
    {"author": "tester2", "message": "Soccer 4"},
  ],
  "0003": [
    {"author": "welcome1", "message": "Welcome 1"},
    {"author": "welcome2", "message": "Welcome 2"},
    {"author": "welcome1", "message": "Welcome 3"},
    {"author": "welcome2", "message": "Welcome 4"},
  ],
};
