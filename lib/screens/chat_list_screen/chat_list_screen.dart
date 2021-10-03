import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:whats_chat/providers/session_provider.dart';
import 'package:whats_chat/constants.dart';
import 'package:whats_chat/utils/icons.dart';
import 'package:whats_chat/widgets/app_scaffold.dart';
import 'package:whats_chat/screens/chat_list_screen/widgets/chat_list_view.dart';

class ChatListScreen extends StatefulWidget {
  static String id = 'chat_list_screen';
  static const int navigationIndex = 1;
  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Socket socket = context.read<SessionProvider>().socket;
    socket.connect();
    socket.onConnect((_) {
      if (context.read<SessionProvider>().rooms != null) {
        return;
      }
      socket.emit('fetch-initial-data', context.read<SessionProvider>().user.id);
    });
    socket.on('initial-data', (data) => context.read<SessionProvider>().updateRooms(data));
    return AppScaffold(
      ChatListScreen.navigationIndex,
      title: 'Chats',
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  top: 15.0,
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                ),
                child: ChatListView(context.watch<SessionProvider>().rooms ?? []),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: add modal pop up to create a new room
        },
        child: kIconsPlus,
        backgroundColor: kSecondaryAccent,
      ),
    );
  }
}
