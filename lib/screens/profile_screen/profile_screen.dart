import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_chat/providers/session_provider.dart';
import 'package:whats_chat/models/user.dart';
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
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      ProfileScreen.navigationIndex,
      title: 'Profile',
      body: Column(
        children: [
          Text('${context.watch<SessionProvider>().user}'),
          TextButton(
            onPressed: () {
              // context.read<SessionProvider>().addData("state updated data");
            },
            child: Text('click for profile'),
          )
        ],
      ),
    );
  }
}
