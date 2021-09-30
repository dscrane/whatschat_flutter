import 'package:flutter/material.dart';
import 'package:whats_chat/constants.dart';
import 'package:whats_chat/widgets/app_scaffold.dart';
import 'package:whats_chat/widgets/chat_list_view.dart';

class ChatListScreen extends StatefulWidget {
  static String id = 'chat_list_screen';
  static const int navigationIndex = 1;
  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      ChatListScreen.navigationIndex,
      title: 'Chats',
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
        backgroundColor: kSecondaryAccent,
      ),
    );
  }
}
