import 'package:flutter/material.dart';
import 'package:whats_chat/widgets/app_scaffold.dart';

class ProfileScreen extends StatefulWidget {
  static const id = "profile_screen";
  static const int navigationIndex = 0;
  const ProfileScreen();

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      ProfileScreen.navigationIndex,
      title: 'Profile',
      body: Container(),
    );
  }
}
