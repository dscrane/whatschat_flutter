import 'package:flutter/material.dart';

import 'chat_list_tile.dart';
import 'package:whats_chat/constants.dart';
import '../../chat_screen/chat_screen.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({Key? key, this.chats}) : super(key: key);
  final chats;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              ChatScreen.id,
              arguments: ChatScreenArguments(
                chats[index]["name"],
                DummyMessages[chats[index]["_id"]]!.toList(),
              ),
            );
          },
          child: ChatListTile(chatData: chats[index]),
        );
      },
    );
  }
}
