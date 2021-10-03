import 'package:socket_io_client/socket_io_client.dart';
import 'package:whats_chat/utils/log.dart';

class SocketController {
  static Socket _socket = io('http://192.168.1.32:5500',
      OptionBuilder().setTransports(['websocket']).disableAutoConnect().build());

  static get socket => _socket;

  static void createRoom(roomName, userName) {
    socket.emitWithAck(
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
    socket.emitWithAck(
        "rejoin-chatroom",
        [
          newChatroomName,
          oldChatroomName,
          userName,
        ],
        ack: (data) => Log.ack(data));
  }

  static void fetchMessages() {
    // socket.emitWithAck("fetching-messages", chatroomName, ack: (data) => Log.ack(data));
  }
  static void fendMessage() {
    // socket.emitWithAck("new-message", { ...messageData }, ack: (data) => Log.ack(data));
  }
  static void leaveRoom() {
    // socket.emitWithAck("leave-chatroom", chatroomName, userName, ack: (data) => Log.ack(data));
  }
  static void deleteRoom() {
    // socket.emitWithAck("delete-chatroom", chatroomName, ack: (data) => Log.ack(data));
  }
}
