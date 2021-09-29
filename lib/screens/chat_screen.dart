import 'package:flutter/material.dart';
import 'package:whats_chat/widgets/message_bubble.dart';

class ChatScreenArguments {
  final String chatName;
  final List messages;

  ChatScreenArguments(this.chatName, this.messages);
}

class ChatScreen extends StatelessWidget {
  static String id = 'chat_screen';
  ChatScreen({this.chatName, this.messages});
  final String? chatName;
  final List? messages;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ChatScreenArguments;
    print(args.chatName);
    // TODO: Create chat screen display
    return Scaffold(
      appBar: AppBar(
        title: Text(args.chatName),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: args.messages
            .map(
              (message) => MessageBubble(message["message"], message["author"]),
            )
            .toList(),
      ),
    );
  }
}
