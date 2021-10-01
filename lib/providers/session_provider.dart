import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:whats_chat/models/room.dart';
import 'package:whats_chat/models/user.dart';
import 'package:whats_chat/services/networking.dart';

// ignore: prefer_mixin
class SessionProvider with ChangeNotifier, DiagnosticableTreeMixin {
  bool _authenticated = true;
  late User _user;
  late Socket _socket;
  List<Room>? _rooms;
  late String _currentRoom;

  User get user => _user;
  void set user(user) => _user = user;

  bool get authenticated => _authenticated;
  void set authenticated(value) => _authenticated = value;

  List<Room>? get rooms => _rooms;
  void set rooms(rooms) => _rooms = rooms;

  String get currentRoom => _currentRoom;
  void set currentRoom(room) => _currentRoom = room;

  Socket get socket => _socket;
  void set(socket) => _socket = socket;

  Future handleUserLogin(username, password) async {
    try {
      Map<String, dynamic> loginUser = await NetworkHelper.loginUser(username, password);
      User loginUserData = User.fromJsoN(loginUser);
      this._userLoginWithListener(loginUserData);
    } catch (e) {
      print(e);
      this.authenticated = false;
    }
  }

  void updateRooms(List<dynamic> rooms) {
    List<Room> roomList = rooms.map<Room>((room) => Room.fromSocket(room)).toList();
    this._setRoomsWithListener(roomList);
  }

  void _userLoginWithListener(User loginUser) {
    this.user = loginUser;
    this.authenticated = true;
    notifyListeners();
  }

  void _setRoomsWithListener(List<Room> rooms) {
    this.rooms = rooms;
    notifyListeners();
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('rooms', _rooms));
  }
}
