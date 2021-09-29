import 'package:flutter/material.dart';

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
        children: args.messages
            .map(
              (message) => Text(message["message"]),
            )
            .toList(),
      ),
    );
  }
}
