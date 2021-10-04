import 'package:socket_io_client/socket_io_client.dart';
import 'package:whats_chat/utils/log.dart';

class SocketController {
  static Socket _socket = io('http://192.168.1.32:5500',
      OptionBuilder().setTransports(['websocket']).disableAutoConnect().build());

  static get socket => _socket;

  static void initialData(userId) {
    _socket.emitWithAck(
      'fetch-initial-data',
      userId,
      ack: (data) => Log.ack(data),
    );
  }

  static void createRoom(roomName, userName) {
    _socket.emitWithAck(
      "create-chatroom",
      [roomName, userName],
      ack: (data) => Log.ack(data),
    );
  }

  static void joinRoom(String roomName, String userName) {
    _socket.emitWithAck(
      "join-chatroom",
      [roomName, null, userName],
      ack: (data) => Log.ack(data),
    );
  }

  static void rejoinRoom(newChatroomName, oldChatroomName, userName) {
    _socket.emitWithAck(
        "rejoin-chatroom",
        [
          newChatroomName,
          oldChatroomName,
          userName,
        ],
        ack: (data) => Log.ack(data));
  }

  static void fetchMessages(room) {
    Log.emit(['fetching-messages', room]);
    _socket.emitWithAck("fetching-messages", room, ack: (data) => Log.ack(data));
  }

  static void fendMessage() {
    // _socket.emitWithAck("new-message", { ...messageData }, ack: (data) => Log.ack(data));
  }
  static void leaveRoom() {
    // _socket.emitWithAck("leave-chatroom", chatroomName, userName, ack: (data) => Log.ack(data));
  }
  static void deleteRoom() {
    // _socket.emitWithAck("delete-chatroom", chatroomName, ack: (data) => Log.ack(data));
  }
}
