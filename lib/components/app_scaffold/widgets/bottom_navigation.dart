import 'package:flutter/material.dart';
import 'package:whats_chat/screens/chat_list_screen/chat_list_screen.dart';
import 'package:whats_chat/screens/profile_screen/profile_screen.dart';
import 'package:whats_chat/screens/settings_screen/settings_screen.dart';
import 'package:whats_chat/utils/constants.dart';
import 'package:whats_chat/utils/icons.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({Key? key, required int selectedIndex})
      : _selectedIndex = selectedIndex,
        super(key: key);

  final int _selectedIndex;

  @override
  Widget build(BuildContext context) {
    if (_selectedIndex > 3) {
      return SizedBox(
        height: 0.0,
      );
    }
    void _onItemTapped(int index) {
      if (index == 0) {
        Navigator.pushNamedAndRemoveUntil(
            context, ProfileScreen.id, ModalRoute.withName(ChatListScreen.id));
      } else if (index == 1) {
        Navigator.pushNamed(context, ChatListScreen.id);
      } else if (index == 2) {
        Navigator.pushNamedAndRemoveUntil(
            context, SettingsScreen.id, ModalRoute.withName(ChatListScreen.id));
      }
    }

    return BottomNavigationBar(
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
    );
  }
}
