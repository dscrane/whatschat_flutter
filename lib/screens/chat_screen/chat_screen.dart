import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_chat/components/app_scaffold/app_scaffold.dart';
import 'package:whats_chat/models/message.dart';
import 'package:whats_chat/models/room.dart';
import 'package:whats_chat/providers/chat_model.dart';
import 'package:whats_chat/providers/session_model.dart';
import 'package:whats_chat/screens/chat_screen/widgets/message_bubble.dart';
import 'package:whats_chat/utils/constants.dart';

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  static const int navigationIndex = 99;
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _messageTextController = TextEditingController();
  String newMessageText = '';

  void sendNewMessage(BuildContext context) {
    Map<String, String> newMessageData = {
      'message': newMessageText,
      'chatroomName': context.read<ChatsModel>().currentRoom!.name,
      'userId': context.read<SessionModel>().user!.id,
      'author': context.read<SessionModel>().user!.username,
    };

    context.read<ChatsModel>().socketController!.sendMessageEmitter(newMessageData);
  }

  void populateMessageList() {}

  @override
  Widget build(BuildContext context) {
    Room? currentRoom = context.watch<ChatsModel>().currentRoom;
    List<Message> messages = context.watch<ChatsModel>().currentRoom!.messages;

    List<MessageBubble> messageBubbles = messages
        .map((message) => MessageBubble(
              key: Key(message.id),
              message: message,
            ))
        .toList();
    // TODO: Create chat screen display

    return AppScaffold(
      ChatScreen.navigationIndex,
      title: currentRoom!.name,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: ListView(
                reverse: true,
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
