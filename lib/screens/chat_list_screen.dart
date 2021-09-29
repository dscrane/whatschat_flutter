import 'package:flutter/material.dart';
import 'package:whats_chat/constants.dart';
import 'package:whats_chat/widgets/chat_list_view.dart';

class ChatListScreen extends StatelessWidget {
  static String id = 'chat_list_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryDark,
        title: Text('Chats'),
        actions: <Widget>[
          IconButton(
            icon: kSearchIcon,
            onPressed: () {
              // TODO: add slide in animation for the textField
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  top: 15.0,
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                ),
                color: kBackground,
                child: ChatListView(
                  chats: DummyChats,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: add modal pop up to create a new room
        },
        child: kPlusIcon,
      ),
    );
  }
}
