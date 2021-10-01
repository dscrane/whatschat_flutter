import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_chat/constants.dart';
import 'package:whats_chat/providers/session_provider.dart';
import 'package:whats_chat/screens/chat_screen/chat_screen.dart';
import 'package:whats_chat/screens/chat_list_screen/widgets/chat_list_tile.dart';

class ChatListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chats = context.watch<SessionProvider>().rooms;

    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        print(chats[index]);
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              ChatScreen.id,
              arguments: ChatScreenArguments(
                chats[index]["name"],
                DummyMessages[chats[index]["name"]]!.toList(),
              ),
            );
          },
          child: ChatListTile(chatData: chats[index]),
        );
      },
    );
  }
}
