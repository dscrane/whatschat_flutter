import 'package:flutter/material.dart';
import 'package:whats_chat/constants.dart';
import 'package:whats_chat/utils/icons.dart';

class ChatListTile extends StatelessWidget {
  const ChatListTile({Key? key, this.room}) : super(key: key);
  final room;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(flex: 1, child: kUserAvatar),
        Expanded(
          flex: 5,
          child: Container(
            height: 55.0,
            padding: EdgeInsets.all(0.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.0, color: kPrimaryDark),
              ),
            ),
            child: Row(
              children: <Widget>[
                SizedBox(width: 10.0),
                Expanded(
                  flex: 10,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        room.name,
                        style: kChatListTitleStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          room.lastMessage,
                          style: kChatListMessageStyle,
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    icon: kIconsMenu,
                    onPressed: () {
                      // Todo: hook up the context menu for the chat_list_screen
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
