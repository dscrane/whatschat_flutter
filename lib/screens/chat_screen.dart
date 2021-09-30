import 'package:flutter/material.dart';
import 'package:whats_chat/constants.dart';
import 'package:whats_chat/widgets/message_bubble.dart';

class ChatScreenArguments {
  final String chatName;
  final List messages;

  ChatScreenArguments(this.chatName, this.messages);
}

class ChatScreen extends StatefulWidget {
  static String id = 'chat_screen';
  ChatScreen({this.chatName, this.messages});
  final String? chatName;
  final List? messages;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  late String newMessageText;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as ChatScreenArguments;

    List<MessageBubble> messageBubbles = args.messages
        .map(
          (message) => MessageBubble(message["message"], message["author"]),
        )
        .toList();
    // TODO: Create chat screen display

    return Scaffold(
      appBar: AppBar(
        // leading: , // TODO: have the conversation partners avatar show as the leading
        title: Text(args.chatName.toUpperCase()),
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
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
