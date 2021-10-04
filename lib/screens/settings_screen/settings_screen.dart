import 'package:flutter/material.dart';
import 'package:whats_chat/widgets/app_scaffold.dart';

class SettingsScreen extends StatefulWidget {
  static const id = "settings_screen";
  static const int navigationIndex = 2;
  const SettingsScreen();

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      SettingsScreen.navigationIndex,
      title: 'Settings',
      body: Container(),
    );
  }
}
