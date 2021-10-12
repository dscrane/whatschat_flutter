import 'package:flutter/foundation.dart';
import 'package:whats_chat/models/message.dart';
import 'package:whats_chat/models/room.dart';
import 'package:whats_chat/services/socket.dart';

class ChatsModel with ChangeNotifier, DiagnosticableTreeMixin {
  late SocketController _socketController;
  late Room _currentRoom;
  List<Room>? _rooms;

  SocketController get socketController => _socketController;
  void set socketController(socket) => _socketController = socket;

  Room get currentRoom => _currentRoom;
  void set currentRoom(room) => _currentRoom = room;

  List<Room>? get rooms => _rooms;
  void set rooms(rooms) => _rooms = rooms;

  void populateMessages(List<Message> messages) {
    this.currentRoom.messages = messages;
    notifyListeners();
  }

  void displayNewMessage(Message message) {
    this.currentRoom.newMessage(message);
    notifyListeners();
  }

  void updateRooms(List<Room> rooms) {
    this.rooms = rooms;
    notifyListeners();
  }

  void updateNewRoom(Room room) {
    updateCurrentRoom(room);
    List<Room>? roomListToUpdate = this.rooms;
    roomListToUpdate!.add(room);

    this.rooms = roomListToUpdate;
    notifyListeners();
  }

  void updateCurrentRoom(Room room) {
    this.currentRoom = room;
    notifyListeners();
  }
}
