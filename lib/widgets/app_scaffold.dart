import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:whats_chat/utils/constants.dart';
import 'package:whats_chat/providers/session_model.dart';
import 'package:whats_chat/services/networking.dart';
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
  late FocusNode _focusNode;
  late Animation<double> animation;
  late AnimationController _controller;
  TextEditingController _searchController = TextEditingController();
  String searchText = '';
  List<dynamic>? searchResults;

  @override
  void initState() {
    _controller = AnimationController(duration: const Duration(milliseconds: 100), vsync: this);
    animation = Tween<double>(begin: 0.0, end: 290.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void handleChange(value) async {
    if (value == '' && searchResults != null) {
      setState(() {
        searchResults = [];
      });
    } else {
      List<dynamic> response =
          await NetworkHelper.queryForUsers(value, context.read<SessionModel>().user.token);
      print(response);
      setState(() {
        searchResults = response;
        searchText = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (animateTextField) {
      _controller.forward();
      _focusNode.requestFocus();
    } else {
      _controller.reverse();
      _searchController.clear();
    }
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(
        backgroundColor: kPrimary,
        title: Text(widget.title),
        actions: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              width: animation.value,
              child: TextField(
                onChanged: (value) {
                  print(value);
                  handleChange(value);
                },
                controller: _searchController,
                focusNode: _focusNode,
                enabled: animateTextField,
                decoration: kSearchTextFieldDecoration,
                showCursor: false,
                maxLines: 1,
              ),
            ),
          ),
          IconButton(
            icon: actionIcon,
            onPressed: () {
              print('icon pressed animatedTextField ${animateTextField}');
              print('results $searchResults');
              setState(() {
                if (animateTextField) {
                  searchResults = [];
                }
                animateTextField = !animateTextField;
                actionIcon = animateTextField ? kIconsClose : kIconsSearch;
              });
            },
          ),
        ],
        bottom: animateTextField
            ? PreferredSize(
                preferredSize: Size.fromHeight(
                  (searchResults?.length ?? 0.0) * 50.0,
                ),
                child: Container(
                  child: Column(
                    children: (searchResults ?? []).map<Widget>((user) {
                      return GestureDetector(
                        onTap: () {
                          context
                              .read<SessionModel>()
                              .socketController
                              .createPrivateConnectionEmitter(user['username']);
                          setState(() {
                            searchResults = [];
                            animateTextField = false;
                            actionIcon = animateTextField ? kIconsClose : kIconsSearch;
                          });
                        },
                        child: ListTile(
                          title: Text(user['name']),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              )
            : null,
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
