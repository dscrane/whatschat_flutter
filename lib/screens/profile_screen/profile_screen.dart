import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whats_chat/providers/chat_model.dart';
import 'package:whats_chat/utils/constants.dart';
import 'package:whats_chat/providers/session_model.dart';
import 'package:whats_chat/models/user.dart';
import 'package:whats_chat/screens/welcome_screen/welcome_screen.dart';
import 'package:whats_chat/services/networking.dart';
import 'package:whats_chat/widgets/app_scaffold.dart';
import 'package:whats_chat/widgets/rounded_button.dart';

class ProfileScreen extends StatefulWidget {
  static const id = "profile_screen";
  static const int navigationIndex = 0;
  const ProfileScreen();

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void handleLogout() async {
    print('attempting logout');
    var logoutSuccess = await NetworkHelper.logoutUser(context.read<SessionModel>().user.token);
    print(logoutSuccess);
    if (logoutSuccess) {
      // TODO: remove the value of 'token' in shared_preferences on logout
      context.read<SessionModel>().prefs.then((SharedPreferences prefs) {
        prefs.setBool('authenticated', false);
      });
      context.read<ChatsModel>().socketController.socket.disconnect();
      context.read<SessionModel>().prefs.then((SharedPreferences prefs) {
        inspect(prefs);
      });
      context.read<SessionModel>().reset();
      Phoenix.rebirth(context);
      Navigator.pushNamedAndRemoveUntil(
          context, WelcomeScreen.id, ModalRoute.withName(WelcomeScreen.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    User currentUser = context.read<SessionModel>().user;

    return AppScaffold(
      ProfileScreen.navigationIndex,
      title: 'Profile',
      body: Center(
        child: ListView(
          children: <Widget>[
            kBoxMd,
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.memory(
                base64Decode(currentUser.avatar),
                height: 125.0,
                width: 125.0,
                // fit: BoxFit.fill,
              ),
            ),
            kBoxMd,
            ProfileCard(type: 'name', value: currentUser.name),
            kBoxXs,
            ProfileCard(type: 'username', value: currentUser.username),
            kBoxXs,
            ProfileCard(type: 'email', value: currentUser.email),
            kBoxXs,
            ProfileCard(type: 'name', value: 'ROOMS HERE'),
            kBoxXs,
            FractionallySizedBox(
              widthFactor: 0.66,
              child: RoundedButton(
                handlePress: handleLogout,
                title: "Log Out",
                color: kWarning,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    required this.type,
    required this.value,
  }) : super(key: key);

  final String type;
  final dynamic value;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
        leading: Text(
          type.toUpperCase(),
          style: kChatListTitleStyle,
        ),
        title: Center(
          child: Text(
            value,
            style: kChatListMessageStyle,
          ),
        ),
      ),
    );
  }
}
