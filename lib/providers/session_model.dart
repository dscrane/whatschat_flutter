import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whats_chat/models/message.dart';
import 'package:whats_chat/models/room.dart';
import 'package:whats_chat/models/user.dart';
import 'package:whats_chat/services/networking.dart';
import 'package:whats_chat/services/socket.dart';

// ignore: prefer_mixin
class SessionModel with ChangeNotifier, DiagnosticableTreeMixin {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _authenticated = false;
  late User _user;
  late SocketController _socketController;
  List<Room>? _rooms;
  late Room _currentRoom;

  Future<SharedPreferences> get prefs => _prefs;

  User get user => _user;
  void set user(user) => _user = user;

  bool get authenticated => _authenticated;
  void set authenticated(value) => _authenticated = value;

  List<Room>? get rooms => _rooms;
  void set rooms(rooms) => _rooms = rooms;

  Room get currentRoom => _currentRoom;
  void set currentRoom(room) => _currentRoom = room;

  SocketController get socketController => _socketController;
  void set socketController(socket) => _socketController = socket;

  Future handleUserLogin(user, token) async {
    this.user = User.fromJson(user, token);
    this.authenticated = true;
    notifyListeners();
  }

  void populateMessages(List<dynamic> messages) {
    List<Message> messageList = messages
        .map<Message>(
          (message) => Message.fromSocket(message),
        )
        .toList();
    this.currentRoom.messages = messageList;
    notifyListeners();
  }

  void displayNewMessage(message) {
    Message newMessage = Message.fromSocket(message);

    this.currentRoom.newMessage(newMessage);
    notifyListeners();
  }

  void updateRooms(List<dynamic> rooms) {
    List<Room> roomList = rooms
        .map<Room>(
          (room) => Room.fromSocket(room,
              currentUser: room['type'] == 'private' ? this.user.username : null),
        )
        .toList();
    this.rooms = roomList;
    notifyListeners();
  }

  void updateNewRoom(room) {
    print('updatenewroom');
    Room newRoom =
        Room.fromSocket(room, currentUser: room['type'] == 'private' ? this.user.username : null);
    updateCurrentRoom(newRoom);

    List<Room>? roomListToUpdate = this.rooms;
    roomListToUpdate!.add(newRoom);

    this.rooms = roomListToUpdate;
    notifyListeners();
  }

  void updateCurrentRoom(Room room) {
    this.currentRoom = room;
    notifyListeners();
  }

  void userLogin(User loginUser) {
    this.user = loginUser;
    this.authenticated = true;
    notifyListeners();
  }

  void reset() {
    this.authenticated = false;
    this.user = User;
    this.rooms = [];
    this.currentRoom = Room;
    this.socketController = SocketController;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('rooms', _rooms));
  }
}
