import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:whats_chat/models/user.dart';
import 'package:whats_chat/services/networking.dart';

// ignore: prefer_mixin
class SessionProvider with ChangeNotifier, DiagnosticableTreeMixin {
  late User _user;
  late bool _authenticated;
  late IO.Socket _socket;
  List<Map<String, dynamic>> _rooms = [];

  User get user => _user;
  void set user(User user) => _user = user;

  bool get authenticated => _authenticated;
  void set authenticated(value) => _authenticated = value;

  List<Map<String, dynamic>> get rooms => _rooms;
  void set rooms(rooms) => _rooms = rooms;

  IO.Socket get socket => _socket;
  IO.Socket set(socketInstance) => _socket = socketInstance;

  Future handleUserLogin(username, password) async {
    try {
      Map<String, dynamic> loginUser = await NetworkHelper.loginUser(username, password);
      User loginUserData = User.fromJsoN(loginUser);
      this.userLogin(loginUserData);
    } catch (e) {
      print(e);
      this.authenticated = false;
    }
  }

  void updateRooms(List<dynamic> rooms) {
    List<Map<String, dynamic>> roomList =
        rooms.map((chat) => Map<String, dynamic>.from(chat)).toList();

    this._setRooms(roomList);
  }

  void userLogin(User loginUser) {
    this.user = loginUser;
    this.authenticated = true;
    notifyListeners();
  }

  void _setRooms(List<Map<String, dynamic>> rooms) {
    this.rooms = rooms;
    notifyListeners();
  }

  void failedLogin() {
    this.authenticated = false;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IterableProperty('rooms', _rooms));
  }
}
