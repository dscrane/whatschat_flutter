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

  void initializeSocketController(socketControllerInstance) {
    this.socketController = socketControllerInstance;
  }

  // handles populating previous messages when a room is entered
  void populateMessages(List<Message> messages) {
    this.currentRoom!.messages = messages;
    notifyListeners();
    Log.chatModel('populateMessages');
  }

  // handles adding a newly received message to the correct room
  void displayNewMessage(Message message) {
    this.currentRoom!.newMessage(message);
    notifyListeners();
    Log.chatModel('displayNewMessage');
  }

  // handles updating rooms when a user logs in
  void updateRooms(List<Room> rooms) {
    this.rooms = rooms;
    notifyListeners();
    Log.chatModel('updateRooms');
  }

  // handles updating rooms and currentRoom when a new room is created
  void updateNewRoom(List<Room> rooms, Room room) {
    this.currentRoom = room;
    this.rooms = rooms;
    notifyListeners();
    Log.chatModel('updateNewRoom');
  }

  // handles updating the current room when it is selected from ChatListScreen
  void updateCurrentRoom(Room room) {
    this.currentRoom = room;
    notifyListeners();
    Log.chatModel('updateCurrentRoom');
  }

  // reset ChatsModel state on logout
  void reset() {
    this.rooms = <Room>[];
    this.currentRoom = null;
    this.socketController = null;
  }
}
