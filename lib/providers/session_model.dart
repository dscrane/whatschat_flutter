import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whats_chat/models/user.dart';
import 'package:whats_chat/utils/log.dart';

// ignore: prefer_mixin
class SessionModel with ChangeNotifier, DiagnosticableTreeMixin {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _authenticated = false;
  User? _user;
  bool _darkTheme = true;

  Future<SharedPreferences> get prefs => _prefs;

  User? get user => _user;
  void set user(user) => _user = user;

  bool get authenticated => _authenticated;
  void set authenticated(value) => _authenticated = value;

  bool get darkTheme => _darkTheme;
  void set darkTheme(value) => _darkTheme = value;

  // handles user login and updates current user and authentication state
  void handleUserLogin(Map<String, dynamic> user, String token) {
    this.user = User.fromJson(user, token);
    this.authenticated = true;
    notifyListeners();
    Log.sessionModel('handleUserLogin');
  }

  // handles populating user state from SharePreferences with LoginScreen is bypassed
  void updateUser(User user) {
    this.user = user;
    notifyListeners();
    Log.sessionModel('updateUser');
  }

  void updateDarkTheme(bool themeBool) {
    this.darkTheme = themeBool;
    notifyListeners();
    Log.sessionModel('updateDarkTheme');
  }

  // reset SessionModel state on logout
  void reset() {
    this.authenticated = false;
    this.user = null;
  }
}
