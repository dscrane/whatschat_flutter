import 'package:flutter/material.dart';
import 'package:whats_chat/constants.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble(this.message, this.author);
  final String message;
  final String author;
  @override
  Widget build(BuildContext context) {
    // TODO: style the send and received messages
    // TODO: bubble tip points toward the message sender
    // TODO: bubbles will show the timestamp for the messages
    // TODO:
    return Row(
      mainAxisAlignment:
          author == 'user1' ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
          color: author == 'user1' ? kSecondary : kPrimary,
          height: 50.0,
          child: Text(message),
        ),
      ],
    );
  }
}

/*
    return Container(
      color: author == 'user1' ? kSecondary : kPrimary,
      height: 50.0,
      child: Row(
        children: [
          Text(message),
        ],
      ),
    );
    */
