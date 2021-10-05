import 'package:flutter/material.dart';
import 'package:whats_chat/constants.dart';
import 'package:whats_chat/utils/icons.dart';
import 'package:whats_chat/screens/chat_list_screen/chat_list_screen.dart';
import 'package:whats_chat/screens/profile_screen/profile_screen.dart';
import 'package:whats_chat/screens/settings_screen/settings_screen.dart';

class AppScaffold extends StatefulWidget {
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
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> with SingleTickerProviderStateMixin {
  bool animateTextField = false;
  Icon actionIcon = kIconsSearch;
  late Animation<double> animation;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(duration: const Duration(milliseconds: 100), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 290.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (animateTextField) {
      _controller.forward();
    } else if (!animateTextField) {
      _controller.reverse();
    }
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kPrimary,
        title: Text(widget.title),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
            width: animation.value,
            child: Center(
              child: TextField(
                decoration: kSearchTextFieldDecoration,
                maxLines: null,
              ),
            ),
          ),
          IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                animateTextField = !animateTextField;
                actionIcon = animateTextField ? kIconsClose : kIconsSearch;
              });
            },
          ),
        ],
      ),
      body: widget.body,
      bottomNavigationBar: BottomNavigation(selectedIndex: widget._selectedIndex),
    );
  }
}

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    Key? key,
    required int selectedIndex,
  })  : _selectedIndex = selectedIndex,
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
        Navigator.pushNamed(context, ProfileScreen.id);
      } else if (index == 1) {
        Navigator.pushNamed(context, ChatListScreen.id);
      } else if (index == 2) {
        Navigator.pushNamed(context, SettingsScreen.id);
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
