import 'package:flutter/material.dart';

import 'chat_list_tile.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({Key? key, this.chats}) : super(key: key);
  final chats;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        print(chats[index]);
        return ChatListTile(chatData: chats[index]);
      },
    );
  }
}
