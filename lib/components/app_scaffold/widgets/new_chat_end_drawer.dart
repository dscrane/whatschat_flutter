import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:whats_chat/providers/chat_model.dart';
import 'package:whats_chat/providers/session_model.dart';
import 'package:whats_chat/services/networking.dart';
import 'package:whats_chat/utils/constants.dart';

class NewChatDrawer extends StatefulWidget {
  const NewChatDrawer({Key? key}) : super(key: key);

  @override
  _NewChatDrawerState createState() => _NewChatDrawerState();
}

class _NewChatDrawerState extends State<NewChatDrawer> {
  TextEditingController _searchController = TextEditingController();
  bool bottomSheetTextField = false;
  String searchText = '';
  List<dynamic>? searchResults;

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
    return Container(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0, bottom: 15.0),
            child: TextField(
              onChanged: (value) {
                // handleChange(value);
              },
              autofocus: true,
              controller: _searchController,
              decoration: kSearchTextFieldDecoration,
              showCursor: false,
              maxLines: 1,
            ),
          ),
          Column(
            children: (searchResults ?? []).map<Widget>((user) {
              return GestureDetector(
                onTap: () {
                  context
                      .read<ChatsModel>()
                      .socketController!
                      .createPrivateConnectionEmitter(user['username']);
                  setState(() {
                    bottomSheetTextField = false;
                  });
                },
                child: ListTile(
                  title: Text(user['name']),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
