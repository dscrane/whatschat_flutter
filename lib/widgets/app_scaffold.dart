import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:whats_chat/providers/chat_model.dart';
import 'package:whats_chat/providers/session_model.dart';
import 'package:whats_chat/screens/chat_list_screen/chat_list_screen.dart';
import 'package:whats_chat/screens/profile_screen/profile_screen.dart';
import 'package:whats_chat/screens/settings_screen/settings_screen.dart';
import 'package:whats_chat/services/networking.dart';
import 'package:whats_chat/utils/constants.dart';
import 'package:whats_chat/utils/icons.dart';

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
  late FocusNode _focusNode;
  late Animation<double> animation;
  late AnimationController _controller;
  TextEditingController _searchController = TextEditingController();

  bool animateTextField = false;
  Icon actionIcon = kIconsSearch;

  String searchText = '';
  List<dynamic>? searchResults;

  @override
  void initState() {
    // initialize animation controller for the slide out input field
    _controller = AnimationController(duration: const Duration(milliseconds: 100), vsync: this);
    // define the animation to perform on the input field
    animation = Tween<double>(begin: 0.0, end: 290.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
    // initialize focus node for the input field
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // dispose of controllers when widget is removed from tree
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void handleChange(value) async {
    // do not return all users when an empty string is provided
    if (value == '' && searchResults != null) {
      setState(() {
        searchResults = [];
      });
    } else {
      // query API for users with entered "name" or "username"
      List<dynamic> response =
          await NetworkHelper.queryForUsers(value, context.read<SessionModel>().user!.token);
      // update state with the returned list of users
      setState(() {
        searchResults = response;
        searchText = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // check current state of animateTextField and define animation and focus accordingly
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
        automaticallyImplyLeading: widget._selectedIndex != ChatListScreen.navigationIndex,
        backgroundColor: kPrimary,
        title: Text(widget.title),
        actions: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 0.0, vertical: 0.0),
              width: animation.value,
              child: TextField(
                onChanged: (value) {
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
                              .read<ChatsModel>()
                              .socketController!
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
      floatingActionButton: widget.floatingActionButton ?? null,
    );
  }
}

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
