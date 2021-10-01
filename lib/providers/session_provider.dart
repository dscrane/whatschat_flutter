import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:whats_chat/models/user.dart';
import 'package:whats_chat/services/networking.dart';

// ignore: prefer_mixin
class SessionProvider with ChangeNotifier, DiagnosticableTreeMixin {
  late User _user;
  bool _authenticated = false;
  List<Map<String, dynamic>> _rooms = [];

  User get user => _user;
  void set user(User user) => _user = user;

  bool get authenticated => _authenticated;
  void set authenticated(value) => _authenticated = value;

  List<Map<String, dynamic>> get rooms => _rooms;
  void set rooms(rooms) => _rooms = rooms;

  Future<bool> handleUserLogin(username, password) async {
    try {
      Map<String, dynamic> loginUser = await NetworkHelper.loginUser(username, password);
      User loginUserData = User.fromJsoN(loginUser);
      this.userLogin(loginUserData);
      List<Map<String, dynamic>> fetchedRooms = await NetworkHelper.getRooms(this._user.rooms);
      this.setRooms(fetchedRooms);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  void userLogin(User loginUser) {
    this.user = loginUser;
    this.authenticated = true;
    notifyListeners();
  }

  void setRooms(List<Map<String, dynamic>> rooms) {
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
