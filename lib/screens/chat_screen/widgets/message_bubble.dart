import 'package:flutter/material.dart';
import 'package:whats_chat/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:whats_chat/models/message.dart';
import 'package:whats_chat/providers/session_model.dart';

Size _textSize(String text, TextStyle style) {
  final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style), maxLines: 1, textDirection: TextDirection.ltr)
    ..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.size;
}

String _formatTimeStamp(DateTime timestamp) {
  String timestampMinute =
      timestamp.minute < 10 ? '0${timestamp.minute}' : timestamp.minute.toString();
  if (timestamp.hour > 11) {
    return '${timestamp.hour % 12}:${timestampMinute} PM';
  } else {
    return '${timestamp.hour}:${timestampMinute} AM';
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({required Key key, required Message message})
      : this.message = message,
        super(key: key);
  final Message message;

  @override
  Widget build(BuildContext context) {
    final isCurrentUser = message.author == context.read<SessionModel>().user.username;
    final timestamp = _formatTimeStamp(message.timestamp);
    final textSize = _textSize(message.message, kMessageTextStyle);

    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? kSentMessageStyle['alignment'] : kReceivedMessageStyle['alignment'],
        children: <Widget>[
          Material(
            elevation: 0.0,
            borderRadius:
                isCurrentUser ? kSentMessageStyle['border'] : kReceivedMessageStyle['border'],
            color: kMessageSent.withOpacity(isCurrentUser ? 1.0 : 0.2),
            child: Container(
              width: textSize.width * 1.3,
              constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width * 0.3,
                  maxWidth: MediaQuery.of(context).size.width * 0.5),
              child: Padding(
                padding: EdgeInsets.only(top: 5.0, left: 10.0, right: 10.0, bottom: 5.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FractionallySizedBox(
                      widthFactor: 1.0,
                      child: Text(
                        message.author,
                        // textAlign: ,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: kTextLightFaded,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 2.5, left: 0.0, right: 0.0, bottom: 0.0),
                      child: FractionallySizedBox(
                        widthFactor: 1.0,
                        child: Text(
                          message.message,
                          textAlign: TextAlign.start,
                          style: kMessageTextStyle,
                        ),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: 1.0,
                      child: Text(
                        timestamp,
                        textAlign: TextAlign.end,
                        style: kMessageTimestampStyle,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
