import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_chat/constants.dart';
import 'package:whats_chat/models/room.dart';
import 'package:whats_chat/providers/session_provider.dart';

import 'package:whats_chat/widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
  }

  final messageTextController = TextEditingController();
  late String newMessageText;
  var messages = [];

  @override
  Widget build(BuildContext context) {
    Room currentRoom = context.watch<SessionProvider>().currentRoom;

    List<MessageBubble> messageBubbles = currentRoom.messages
        .map(
          (message) => MessageBubble(message),
        )
        .toList();
    // TODO: Create chat screen display

    return Scaffold(
      appBar: AppBar(
        // leading: , // TODO: have the conversation partners avatar show as the leading
        title: Text(currentRoom.name.toUpperCase()),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                children: messageBubbles,
              ),
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        newMessageText = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      messageTextController.clear();
                      print(newMessageText);
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonStyle,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class ChatScreenArguments {
//   final String chatName;
//   final List messages;
//
//   ChatScreenArguments(this.chatName, this.messages);
// }
