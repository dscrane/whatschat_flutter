import 'package:flutter/material.dart';
import 'package:whats_chat/constants.dart';
import 'package:provider/provider.dart';
import 'package:whats_chat/models/message.dart';
import 'package:whats_chat/providers/session_provider.dart';

class MessageBubble extends StatelessWidget {
  const MessageBubble({required Key key, required Message message})
      : this.message = message,
        super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    final isCurrentUser = message.author == context.read<SessionProvider>().user.username;
    final timestampString = message.timestamp.hour > 11
        ? '${message.timestamp.hour % 12}:${message.timestamp.minute} PM'
        : '${message.timestamp.hour}:${message.timestamp.minute} AM';
    final border = isCurrentUser ? kSentMessageStyle['border'] : kReceivedMessageStyle['border'];
    final background =
        isCurrentUser ? kSentMessageStyle['background'] : kReceivedMessageStyle['background'];
    final alignment =
        isCurrentUser ? kSentMessageStyle['alignment'] : kReceivedMessageStyle['alignment'];
    final text = isCurrentUser ? kSentMessageStyle['text'] : kReceivedMessageStyle['text'];

    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: alignment,
        children: <Widget>[
          Text(
            message.author,
            style: TextStyle(
              fontSize: 12.0,
              color: kTextLightFaded,
            ),
          ),
          Material(
            elevation: 5.0,
            borderRadius: border,
            color: background,
            child: Padding(
              padding: EdgeInsets.only(top: 5.0, left: 8.0, right: 8.0, bottom: 5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    message.message,
                    style: text,
                  ),
                  Text(
                    timestampString,
                    style: kMessageTimestampStyle,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
