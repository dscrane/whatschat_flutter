import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/src/manager.dart';
import 'package:whats_chat/utils/log.dart';
import 'dart:developer';

class SocketController {
  late Socket _socket;
  SocketController({userId, username, token})
      : this._socket = io(
          'http://192.168.1.32:5500',
          OptionBuilder()
              .setTransports(['websocket'])
              .setQuery({"username": username, "userId": userId, "token": token})
              .disableAutoConnect()
              .build(),
        );

  Socket get socket => _socket;

  void initializeSession() {
    socket.connect();
  }

  void initialData() {
    Log.emit(['initial-data', null]);

    _socket.emitWithAck(
      'fetch-initial-data',
      null,
      ack: (data) => Log.ack(data),
    );
  }

  void createRoom(roomName, userName) {
    Log.emit(['create-room', roomName]);

    _socket.emitWithAck(
      "create-chatroom",
      [roomName, userName],
      ack: (data) => Log.ack(data),
    );
  }

  void joinRoom(String roomName, String userName) {
    Log.emit(['join-room', roomName]);

    _socket.emitWithAck(
      "join-chatroom",
      [roomName, null, userName],
      ack: (data) => Log.ack(data),
    );
  }

  void rejoinRoom(newChatroomName, oldChatroomName, userName) {
    _socket.emitWithAck(
        "rejoin-chatroom",
        [
          newChatroomName,
          oldChatroomName,
          userName,
        ],
        ack: (data) => Log.ack(data));
  }

  void fetchMessages(room) {
    Log.emit(['fetching-messages', room]);

    _socket.emitWithAck("fetching-messages", room, ack: (data) => Log.ack(data));
  }

  void sendMessage(messageData) {
    Log.emit(['new-messages', messageData]);

    _socket.emitWithAck("new-message", messageData, ack: (data) => Log.ack(data));
  }

  void leaveRoom() {
    // _socket.emitWithAck("leave-chatroom", chatroomName, userName, ack: (data) => Log.ack(data));
  }
  void deleteRoom() {
    // _socket.emitWithAck("delete-chatroom", chatroomName, ack: (data) => Log.ack(data));
  }
}
