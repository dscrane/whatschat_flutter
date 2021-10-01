import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart';
import 'package:whats_chat/constants.dart';

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
      return json.decode(response.body)["user"];
    } catch (e) {
      // TODO: add error codes to server code
      // TODO: handle errors from server
      print(e);
      return null;
    }
  }

  // static Future getRooms(rooms) async {
  //   // Format and encode data in JSON format for request body
  //   Map<String, List> requestMap = {"rooms": rooms};
  //   String encodedData = json.encode(requestMap);
  //   try {
  //     // Post users current list of rooms
  //     Response response = await post(
  //       Uri.parse('http://192.168.1.32:5500/MessagesDisplay'),
  //       body: encodedData,
  //       headers: {HttpHeaders.authorizationHeader: testToken},
  //     );
  //
  //     // Decode json return in response body
  //     List<dynamic> decodedData = json.decode(response.body)["chats"];
  //
  //     // Reformat response body data into an list of chat rooms
  //     List<Map<String, dynamic>> roomList =
  //         decodedData.map((chat) => Map<String, dynamic>.from(chat)).toList();
  //
  //     // Return the formatted list of rooms
  //     return roomList;
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  static Future getUserProfile() async {
    // return user profile from database
    try {
      Response response = await get(Uri.parse('http://192.168.1.32:5500/user'),
          headers: {"Authorization": 'Bearer $testToken'});
      print(response.statusCode);
      print(response.body);
    } catch (e) {
      // TODO: handle errors from server
      print(e);
    }
  }

  Future getMessages(chatId) async {
    // return list of messages for currently selected chat room
  }
}
