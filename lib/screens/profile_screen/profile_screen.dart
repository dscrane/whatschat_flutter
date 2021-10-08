import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:whats_chat/constants.dart';
import 'package:whats_chat/providers/session_provider.dart';
import 'package:whats_chat/models/user.dart';
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
    var logoutSuccess = await NetworkHelper.logoutUser(context.read<SessionProvider>().user.token);
    print(logoutSuccess);
    if (logoutSuccess) {
      context.read<SessionProvider>().socketController.socket.disconnect();
      // context.read<SessionProvider>().reset();
      Phoenix.rebirth(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    User currentUser = context.read<SessionProvider>().user;

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
            kBoxSm,
            ProfileCard(type: 'username', value: currentUser.username),
            kBoxSm,
            ProfileCard(type: 'email', value: currentUser.email),
            kBoxSm,
            ProfileCard(type: 'name', value: 'ROOMS HERE'),
            kBoxSm,
            RoundedButton(
              handlePress: handleLogout,
              title: "Log Out",
              color: kWarning,
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
