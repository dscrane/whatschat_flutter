import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:whats_chat/utils/constants.dart';

class NetworkHelper {
  final urlString = "http://192.168.1.32:5500";

  static Future loginUser(String username, String password) async {
    // Format and encode data in JSON format for request body
    Map<String, String> requestMap = {"username": username, "password": password};
    String encodedData = json.encode(requestMap);

    try {
      // POST login credentials to server and wait for response
      Response response = await post(
        Uri.parse('http://192.168.1.32:5500/login-user'),
        body: encodedData,
        headers: {HttpHeaders.authorizationHeader: testToken},
      );
      // if successful response return User object from response body

      return json.decode(response.body);
    } catch (e) {
      // TODO: add error codes to server code
      // TODO: handle errors from server
      print(e);
      return null;
    }
  }

  static Future getUserProfile() async {
    // return user profile from database
    try {
      Response response = await get(Uri.parse('http://192.168.1.32:5500/user'),
          headers: {"Authorization": 'Bearer $testToken'});
      print(response.statusCode);
      print(response.body);
      return json.decode(response.body);
    } catch (e) {
      // TODO: handle errors from server
      print(e);
    }
  }

  static Future queryForUsers(name, token) async {
    Map<String, String> requestMap = {"name": name};
    String encodedData = json.encode(requestMap);
    try {
      Response response = await post(
        Uri.parse('http://192.168.1.32:5500/users'),
        body: encodedData,
        headers: {"Authorization": 'Bearer $token'},
      );
      return jsonDecode(response.body);
    } catch (e) {
      print(e);
      // TODO: handle error from server
    }
  }

  static Future logoutUser(token) async {
    try {
      Response response = await post(
        Uri.parse('http://192.168.1.32:5500/logout'),
        body: null,
        headers: {"Authorization": 'Bearer $token'},
      );
      return jsonDecode(response.body)["logout"];
      // TODO remove the token from share_preferences on logout

    } catch (e) {
      print(e);
    }
  }

  Future getMessages(chatId) async {
    // return list of messages for currently selected chat room
  }
}
