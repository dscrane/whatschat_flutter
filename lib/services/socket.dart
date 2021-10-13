import 'package:socket_io_client/socket_io_client.dart';
import 'package:whats_chat/models/message.dart';
import 'package:whats_chat/models/room.dart';
import 'package:whats_chat/providers/chat_model.dart';
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

  void onInitialData(
    List<dynamic> rooms,
    SessionModel sessionReader,
    ChatsModel chatReader,
  ) {
    List<Room> roomList = rooms
        .map<Room>(
          (room) => Room.fromSocket(
            room,
            currentUser: room['type'] == 'private' ? sessionReader.user!.username : null,
          ),
        )
        .toList();
    chatReader.updateRooms(roomList);
  }

  void createPublicConnectionEmitter(
    String roomName,
    String userName,
  ) {
    Log.emit(['create-room', roomName]);

    _socket.emitWithAck(
      "create-chatroom",
      [roomName, userName],
      ack: (data) => Log.ack(data),
    );
  }

  void onPublicConnection(
    Map<String, dynamic> room,
    SessionModel sessionReader,
    ChatsModel chatReader,
  ) {}

  void createPrivateConnectionEmitter(String userToFind) {
    Log.emit(['create-private-connection', userToFind]);

    _socket.emitWithAck("create-private", userToFind, ack: (data) => Log.ack(data));
  }

  void onPrivateConnection(
    Map<String, dynamic> room,
    SessionModel sessionReader,
    ChatsModel chatReader,
  ) {
    Room newRoom = Room.fromSocket(room, currentUser: sessionReader.user!.username);

    List<Room>? roomListToUpdate = chatReader.rooms;
    roomListToUpdate!.add(newRoom);

    chatReader.updateNewRoom(roomListToUpdate, newRoom);
  }

  void joinRoomEmitter(
    String roomName,
    String userName,
  ) {
    Log.emit(['join-room', roomName]);

    _socket.emitWithAck(
      "join-chatroom",
      [roomName, null, userName],
      ack: (data) => Log.ack(data),
    );
  }

  void onJoinedRoom() {}

  void rejoinRoomEmitter(
    String newChatroomName,
    String oldChatroomName,
    String userName,
  ) {
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

  void onFetchedMessaged(
    List<dynamic> messages,
    ChatsModel chatReader,
  ) {
    List<Message> messageList =
        messages.map<Message>((message) => Message.fromSocket(message)).toList();
    chatReader.populateMessages(messageList);
  }

  void sendMessageEmitter(
    Map<String, String> messageData,
  ) {
    Log.emit(['new-messages', messageData]);

    _socket.emitWithAck("new-message", messageData, ack: (data) => Log.ack(data));
  }

  void onReturnMessage(
    Map<String, dynamic> message,
    ChatsModel chatReader,
  ) {
    Message newMessage = Message.fromSocket(message);
    chatReader.displayNewMessage(newMessage);
  }

  void leaveRoom() {
    // _socket.emitWithAck("leave-chatroom", chatroomName, userName, ack: (data) => Log.ack(data));
  }
  void deleteRoom() {
    // _socket.emitWithAck("delete-chatroom", chatroomName, ack: (data) => Log.ack(data));
  }
}
