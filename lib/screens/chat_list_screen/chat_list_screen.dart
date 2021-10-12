import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:whats_chat/providers/chat_model.dart';
import 'package:whats_chat/providers/session_model.dart';
import 'package:whats_chat/utils/constants.dart';
import 'package:whats_chat/utils/exceptions.dart';
import 'package:whats_chat/services/socket.dart';
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
  bool _fetching = false;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    enableLoadingIndicator();

    context.read<ChatsModel>().socketController = SocketController(
      userId: context.read<SessionModel>().user.id,
      username: context.read<SessionModel>().user.username,
      token: context.read<SessionModel>().user.token,
    );

    connectToServer();
    super.initState();
  }

  void enableLoadingIndicator() {
    setState(() {
      _fetching = true;
    });
  }
  //
  // @override
  // dispose() {
  //   super.dispose();
  // }

  void connectToServer() {
    ChatsModel chatsReader = context.read<ChatsModel>();
    SessionModel sessionReader = context.read<SessionModel>();
    SocketController socketController = chatsReader.socketController;
    Socket socket = socketController.socket;
    socketController.initializeSessionEmitter();
    socket.onConnect((_) {
      if (chatsReader.rooms != null) {
        return;
      }
      socketController.initialDataEmitter();
    });
    socket.on(
      'initial-data',
      (data) => socketController.onInitialData(data, sessionReader, chatsReader),
    );
    socket.on(
      'fetched-messages',
      (data) => socketController.onFetchedMessaged(data[1], chatsReader),
    );
    socket.on(
      'public-connection-created',
      (data) => socketController.onPublicConnection(data, sessionReader, chatsReader),
    );
    socket.on(
      'private-connection-created',
      (data) => socketController.onPrivateConnection(data, sessionReader, chatsReader),
    );
    socket.on(
      'return-message',
      (data) => socketController.onReturnMessage(data[1], chatsReader),
    );

    socket.on(
      'fetch-messages',
      (data) => socketController.fetchMessagesEmitter(data),
    );
    socket.on('error', (data) {
      try {
        throw SocketException(data);
      } on SocketException catch (e) {
        if (e.name == 'UserQueryError') {
          print(e.message);
          Navigator.pop(context);
        } else {
          print(e);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (context.watch<ChatsModel>().rooms?.length != null) {
      setState(() {
        _fetching = false;
      });
    }
    return AppScaffold(
      ChatListScreen.navigationIndex,
      title: 'Chats',
      body: SafeArea(
        child: ModalProgressHUD(
          inAsyncCall: _fetching,
          progressIndicator: CircularProgressIndicator(
            color: kPrimaryAccent,
            backgroundColor: Colors.white,
            semanticsLabel: 'Fetching chats...',
          ),
          // opacity: 0.5,
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
                  child: ChatListView(context.watch<ChatsModel>().rooms ?? []),
                ),
              ),
            ],
          ),
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
