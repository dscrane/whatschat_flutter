import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:whats_chat/utils/constants.dart';
import 'package:whats_chat/providers/session_model.dart';
import 'package:whats_chat/utils/icons.dart';

class ChatListTile extends StatelessWidget {
  const ChatListTile({Key? key, this.room}) : super(key: key);
  final room;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 10.0, top: 5.0, right: 5.0, bottom: 5.0),
          child: ClipOval(
            child: Image.memory(
              base64Decode(context.read<SessionModel>().user.avatar),
              height: 35.0,
              width: 35.0,
              fit: BoxFit.fill,
            ),
          ),
        ),
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
                  child: PopupMenuButton(
                    child: kIconsMenu,
                    onSelected: (result) {
                      // Todo: hook up the context menu for the chat_list_screen
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      const PopupMenuItem(child: Text('Info')),
                      const PopupMenuItem(child: Text('Archive')),
                      const PopupMenuItem(child: Text('Close Chat')),
                      const PopupMenuItem(child: Text('Delete Chat')),
                    ],
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
