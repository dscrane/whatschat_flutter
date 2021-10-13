import 'package:flutter/foundation.dart';
import 'package:whats_chat/models/message.dart';
import 'package:whats_chat/models/room.dart';
import 'package:whats_chat/services/socket.dart';
import 'package:whats_chat/utils/log.dart';

class ChatsModel with ChangeNotifier, DiagnosticableTreeMixin {
  SocketController? _socketController;
  Room? _currentRoom;
  List<Room>? _rooms;

  SocketController? get socketController => _socketController;
  void set socketController(socket) => _socketController = socket;

  Room? get currentRoom => _currentRoom;
  void set currentRoom(room) => _currentRoom = room;

  List<Room>? get rooms => _rooms;
  void set rooms(rooms) => _rooms = rooms;

  void populateMessages(List<Message> messages) {
    this.currentRoom!.messages = messages;
    notifyListeners();
    Log.chatModel('populateMessages');
  }

  void displayNewMessage(Message message) {
    this.currentRoom!.newMessage(message);
    notifyListeners();
    Log.chatModel('displayNewMessage');
  }

  void updateRooms(List<Room> rooms) {
    this.rooms = rooms;
    notifyListeners();
    Log.chatModel('updateRooms');
  }

  void updateNewRoom(List<Room> rooms, Room room) {
    this.currentRoom = room;
    this.rooms = rooms;
    notifyListeners();
    Log.chatModel('updateNewRoom');
  }

  void updateCurrentRoom(Room room) {
    this.currentRoom = room;
    notifyListeners();
    Log.chatModel('updateCurrentRoom');
  }

  void reset() {
    this.rooms = <Room>[];
    this.currentRoom = null;
    this.socketController = null;
  }
}
