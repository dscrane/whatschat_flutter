import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

const testToken =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI1ZjYzN2ZkZDBhNDFhZTY5MWM4MjhlNTAiLCJpYXQiOjE2MjkyMTU0NDZ9.7miZHC4A1O5ePvIPwUgfi9aPHkmPO698FIlUxD1olX4";

// Box constants
const kBoxSm = SizedBox(height: 16.0);
const kBoxMd = SizedBox(height: 24.0);
const kBoxLg = SizedBox(height: 32.0);
const kBoxXl = SizedBox(height: 48.0);

// Color scheme constants
const kBackground = Color(0xff4e4b51);
const kPrimary = Color(0xff8741c1);
const kSecondary = Color(0xff2ab2bf);
const kPrimaryLight = Color(0xffba70f4);
const kSecondaryLight = Color(0xff71f5f5);
const kPrimaryDark = Color(0xff44345b);
const kSecondaryDark = Color(0xff375d60);
const kPrimaryDeep = Color(0xff2e094c);
const kSecondaryDeep = Color(0xff095458);
const kPrimaryAccent = Color(0xffd500f9);
const kSecondaryAccent = Color(0xff00e5ff);

const kTextLightFaded = Color(0xFF9793A4);
const kTextLight = Color(0xFFFFFFFF);
const kTextDark = Color(0xFF000000);

// Stylistic constants
const kSendButtonStyle = TextStyle(
  color: kPrimaryLight,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
);

const kMessageTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  hintText: 'Type your message here...',
  border: InputBorder.none,
);

const kMessageContainerDecoration = BoxDecoration(
  border: Border(
    top: BorderSide(color: kPrimaryAccent, width: 2.0),
  ),
);

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
      borderSide: BorderSide(color: kPrimaryAccent, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ));

const kRegistrationTextFieldDecoration = InputDecoration(
    hintStyle: TextStyle(
      color: kTextLightFaded,
    ),
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kSecondaryDark, width: 1.5),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kSecondaryAccent, width: 2.0),
      borderRadius: BorderRadius.all(Radius.circular(32.0)),
    ));

const kMessageTimestampStyle = TextStyle(
  color: kTextLightFaded,
  fontSize: 9.0,
);

const Map<String, dynamic> kSentMessageStyle = {
  'alignment': CrossAxisAlignment.end,
  'background': kSecondaryDark,
  'border': BorderRadius.only(
    topLeft: Radius.circular(10.0),
    topRight: Radius.circular(0.0),
    bottomLeft: Radius.circular(10.0),
    bottomRight: Radius.circular(10.0),
  ),
  'text': TextStyle(
    color: kTextLight,
    fontFamily: 'Source-Sans',
    fontWeight: FontWeight.w500,
    fontSize: 15.0,
  ),
};

const Map<String, dynamic> kReceivedMessageStyle = {
  'alignment': CrossAxisAlignment.start,
  'background': kPrimaryDark,
  'border': BorderRadius.only(
    topLeft: Radius.circular(0.0),
    topRight: Radius.circular(10.0),
    bottomLeft: Radius.circular(10.0),
    bottomRight: Radius.circular(10.0),
  ),
  'text': TextStyle(
    color: kTextLight,
    fontFamily: 'Source-Sans',
    fontWeight: FontWeight.w500,
    fontSize: 15.0,
  ),
};

// Functional constants

// Icon constants
const CircleAvatar kUserAvatar = CircleAvatar(
  child: Icon(
    FontAwesomeIcons.user,
    size: 20.0,
    color: kSecondary,
  ),
  backgroundColor: kTextLight,
  radius: 20.0,
);

const CircleAvatar kUsersAvatar = CircleAvatar(
  child: Icon(
    FontAwesomeIcons.users,
    size: 18.0,
    color: kSecondaryDark,
  ),
  backgroundColor: kTextLight,
  radius: 20.0,
);

// Data constants
const DummyMessages = {
  "Buddies": [
    {"author": "user1", "message": "Message 1"},
    {"author": "user2", "message": "Message 2"},
    {"author": "user1", "message": "Message 3"},
    {"author": "user2", "message": "Message 4"},
  ],
  "soccer": [
    {"author": "user1", "message": "Soccer 1"},
    {"author": "user2", "message": "Soccer 2"},
    {"author": "user1", "message": "Soccer 3"},
    {"author": "user2", "message": "Soccer 4"},
  ],
  "welcome room": [
    {"author": "user1", "message": "Welcome 1"},
    {"author": "user2", "message": "Welcome 2"},
    {"author": "user1", "message": "Welcome 3"},
    {"author": "user2", "message": "Welcome 4"},
  ],
};
