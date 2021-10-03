import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_chat/constants.dart';
import 'package:whats_chat/models/room.dart';
import 'package:whats_chat/providers/session_provider.dart';
import 'package:whats_chat/screens/chat_screen/chat_screen.dart';
import 'package:whats_chat/screens/chat_list_screen/widgets/chat_list_tile.dart';
import 'package:whats_chat/services/socket.dart';

class ChatListView extends StatelessWidget {
  ChatListView(this.rooms);
  final List<Room> rooms;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            context.read<SessionProvider>().currentRoom = rooms[index];
            SocketController.joinRoom(context.read<SessionProvider>().currentRoom.name,
                context.read<SessionProvider>().user.name);
            Navigator.pushNamed(context, ChatScreen.id);
          },
          child: ChatListTile(room: rooms[index]),
        );
      },
    );
  }
}
