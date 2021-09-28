import 'package:flutter/material.dart';
import 'package:whats_chat/constants.dart';

class ChatListTile extends StatelessWidget {
  const ChatListTile({Key? key, this.chatData}) : super(key: key);
  final chatData;

  @override
  Widget build(BuildContext context) {
    print(chatData);
    return ListTile(
      contentPadding: EdgeInsets.all(10.0),
      leading: kUserAvatar,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            chatData["name"],
            style: kChatListTitleStyle,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              chatData["lastMessage"],
              style: kChatListMessageStyle,
            ),
          )
        ],
      ),
      trailing: kMenuIcon,
    );
    ;
  }
}
