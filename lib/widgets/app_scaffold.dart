import 'package:flutter/material.dart';
import 'package:whats_chat/constants.dart';
import 'package:whats_chat/utils/icons.dart';
import 'package:whats_chat/screens/chat_list_screen.dart';
import 'package:whats_chat/screens/profile_screen.dart';
import 'package:whats_chat/screens/settings_screen.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold(
    this._selectedIndex, {
    required this.title,
    required this.body,
    this.floatingActionButton,
  });

  final int _selectedIndex;
  final String title;
  final Widget body;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    void _onItemTapped(int index) {
      if (index == 0) {
        Navigator.pushNamed(context, ProfileScreen.id);
      } else if (index == 1) {
        Navigator.pushNamed(context, ChatListScreen.id);
      } else if (index == 2) {
        Navigator.pushNamed(context, SettingsScreen.id);
      }
    }

    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kPrimary,
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: kIconsSearch,
            onPressed: () {
              // TODO: add slide in animation for the textField
            },
          )
        ],
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: 'Profile',
            icon: kIconsProfile,
          ),
          BottomNavigationBarItem(
            label: 'Chats',
            icon: kIconsChats,
          ),
          BottomNavigationBarItem(
            label: 'Settings',
            icon: kIconsSettings,
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: kSecondaryAccent,
        onTap: _onItemTapped,
      ),
    );
  }
}
