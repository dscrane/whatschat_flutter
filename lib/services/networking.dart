import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:whats_chat/constants.dart';
import 'dart:convert';

class NetworkHelper {
  final urlString = "http://localhost:5500";

  static Future loginUser(String username, String password) async {
    Map<String, String> requestMap = {"username": username, "password": password};
    String encodedData = json.encode(requestMap);
    try {
      http.Response response = await http.post(
        Uri.parse('http://192.168.1.32:5500/login-user'),
        body: encodedData,
        headers: {HttpHeaders.authorizationHeader: testToken},
      );
      return json.decode(response.body)["user"];
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
      http.Response response = await http.get(Uri.parse('http://192.168.1.32:5500/user'),
          headers: {"Authorization": 'Bearer $testToken'});
      print(response.statusCode);
      print(response.body);
    } catch (e) {
      // TODO: handle errors from server
      print(e);
    }
  }

  Future getChats() async {
    // return list of chats from database
  }

  Future getMessages(chatId) async {
    // return list of messages for currently selected chat room
  }
}

// Future getData({username, password}) async {
//   print('getData() hit');
//   http.Response res = await http.post(
//     Uri.parse(
//       'http://localhost:5500/login-user',
//     ),
//     body: {username: username, password: password},
//     headers: {
//       'Access-Control-Allow-Origin': "http://localhost:5500/*",
//       'Content-Security-Policy': "default-src *",
//     },
//   );
//   print(res);
//   if (res.statusCode == 200) {
//     String data = res.body;
//     // return jsonDecode(data);
//   } else {
//     print(res.statusCode);
//   }
// }
