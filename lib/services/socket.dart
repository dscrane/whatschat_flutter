import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/src/manager.dart';
import 'package:whats_chat/models/message.dart';
import 'package:whats_chat/models/room.dart';
import 'package:whats_chat/providers/session_model.dart';
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

  void initializeSessionEmitter() {
    socket.connect();
    inspect(socket);
  }

  void initialDataEmitter() {
    Log.emit(['initial-data', null]);

    _socket.emitWithAck(
      'fetch-initial-data',
      null,
      ack: (data) => Log.ack(data),
    );
  }

  void onInitialData(List<Map<String, dynamic>> rooms, SessionModel sessionReader) {
    print(rooms.runtimeType);
    List<Room> roomList = rooms
        .map<Room>(
          (room) => Room.fromSocket(
            room,
            currentUser: room['type'] == 'private' ? sessionReader.user.username : null,
          ),
        )
        .toList();
    sessionReader.updateRooms(roomList);
  }

  void createPublicConnectionEmitter(String roomName, String userName) {
    Log.emit(['create-room', roomName]);

    _socket.emitWithAck(
      "create-chatroom",
      [roomName, userName],
      ack: (data) => Log.ack(data),
    );
  }

  void onPublicConnection(Map<String, dynamic> room, SessionModel sessionReader) {}

  void createPrivateConnectionEmitter(String userToFind) {
    Log.emit(['create-private-connection', userToFind]);

    _socket.emitWithAck("create-private", userToFind, ack: (data) => Log.ack(data));
  }

  void onPrivateConnection(Map<String, dynamic> room, SessionModel sessionReader) {
    Room newRoom = Room.fromSocket(room, currentUser: sessionReader.user.username);
    sessionReader.updateNewRoom(newRoom);
  }

  void joinRoomEmitter(String roomName, String userName) {
    Log.emit(['join-room', roomName]);

    _socket.emitWithAck(
      "join-chatroom",
      [roomName, null, userName],
      ack: (data) => Log.ack(data),
    );
  }

  void onJoinedRoom() {}

  void rejoinRoomEmitter(String newChatroomName, String oldChatroomName, String userName) {
    _socket.emitWithAck(
        "rejoin-chatroom",
        [
          newChatroomName,
          oldChatroomName,
          userName,
        ],
        ack: (data) => Log.ack(data));
  }

  void fetchMessagesEmitter(String roomName) {
    Log.emit(['fetching-messages', roomName]);

    _socket.emitWithAck("fetching-messages", roomName, ack: (data) => Log.ack(data));
  }

  void onFetchedMessaged(List<Map<String, dynamic>> messages, SessionModel sessionReader) {
    List<Message> messageList =
        messages.map<Message>((message) => Message.fromSocket(message)).toList();
    sessionReader.populateMessages(messageList);
  }

  void sendMessageEmitter(Map<String, String> messageData) {
    Log.emit(['new-messages', messageData]);

    _socket.emitWithAck("new-message", messageData, ack: (data) => Log.ack(data));
  }

  void onReturnMessage(Map<String, dynamic> message, SessionModel sessionReader) {
    Message newMessage = Message.fromSocket(message);
    sessionReader.displayNewMessage(newMessage);
  }

  void leaveRoom() {
    // _socket.emitWithAck("leave-chatroom", chatroomName, userName, ack: (data) => Log.ack(data));
  }
  void deleteRoom() {
    // _socket.emitWithAck("delete-chatroom", chatroomName, ack: (data) => Log.ack(data));
  }
}
