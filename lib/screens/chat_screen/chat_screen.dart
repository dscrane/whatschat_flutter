import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_chat/constants.dart';
import 'package:whats_chat/models/message.dart';
import 'package:whats_chat/models/room.dart';
import 'package:whats_chat/providers/session_provider.dart';
import 'package:whats_chat/services/socket.dart';
import 'package:whats_chat/widgets/app_scaffold.dart';
import 'package:whats_chat/widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageTextController = TextEditingController();
  String newMessageText = '';

  void sendNewMessage(BuildContext context) {
    Map<String, String> newMessageData = {
      'message': newMessageText,
      'chatroomName': context.read<SessionProvider>().currentRoom.name,
      'userId': context.read<SessionProvider>().user.id,
      'author': context.read<SessionProvider>().user.username,
    };

    SocketController.sendMessage(newMessageData);
  }

  void populateMessageList() {}

  @override
  Widget build(BuildContext context) {
    Room currentRoom = context.watch<SessionProvider>().currentRoom;
    List<Message> messages = context.watch<SessionProvider>().currentRoom.messages;

    List<MessageBubble> messageBubbles =
        messages.map((message) => MessageBubble(key: Key(message.id), message: message)).toList();
    // TODO: Create chat screen display

    return AppScaffold(
      99,
      title: currentRoom.name,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ListView(
                reverse: true,
                // controller: _scrollController,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                children: messageBubbles.reversed.toList(),
              ),
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _messageTextController,
                      onChanged: (value) {
                        setState(() {
                          newMessageText = value;
                        });
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      sendNewMessage(context);
                      _messageTextController.clear();
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
