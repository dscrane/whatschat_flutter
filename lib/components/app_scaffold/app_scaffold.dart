import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:whats_chat/components/app_scaffold/widgets/bottom_navigation.dart';
import 'package:whats_chat/components/app_scaffold/widgets/new_chat_end_drawer.dart';
import 'package:whats_chat/providers/chat_model.dart';
import 'package:whats_chat/providers/session_model.dart';
import 'package:whats_chat/screens/chat_list_screen/chat_list_screen.dart';
import 'package:whats_chat/services/networking.dart';
import 'package:whats_chat/utils/constants.dart';
import 'package:whats_chat/utils/icons.dart';

class AppScaffold extends StatefulWidget {
  AppScaffold(
    this._selectedIndex, {
    required this.title,
    required this.body,
  });

  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  final int _selectedIndex;
  final String title;
  final Widget body;

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> with SingleTickerProviderStateMixin {
  TextEditingController _searchController = TextEditingController();
  late FocusNode _focusNode;
  late Animation<double> animation;
  late AnimationController _controller;

  Icon actionIcon = kIconsSearch;
  bool animateTextField = false;
  List<dynamic>? searchResults;
  String searchText = '';

  @override
  initState() {
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

  PreferredSizeWidget? drawAppbarBottom() {
    return searchResults != null && animateTextField
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
        : null;
  }

  Widget? drawFloatingActionButton() {
    return widget._selectedIndex == ChatListScreen.navigationIndex
        ? FloatingActionButton(
            onPressed: () {
              widget._drawerKey.currentState!.openEndDrawer();
            },
            child: kIconsPlus,
            foregroundColor: kTextDarkFaded,
            backgroundColor: kSecondaryAccent,
          )
        : null;
  }

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
      key: widget._drawerKey,
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primaryVariant,
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
        bottom: drawAppbarBottom(),
      ),
      endDrawer: widget._selectedIndex == ChatListScreen.navigationIndex ? NewChatDrawer() : null,
      body: widget.body,
      bottomNavigationBar: BottomNavigation(selectedIndex: widget._selectedIndex),
      floatingActionButton: drawFloatingActionButton(),
    );
  }
}
