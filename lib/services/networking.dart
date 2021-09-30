import 'package:http/http.dart' as http;

class NetworkHelper {
  final urlString = "http://localhost:5500";

  Future getUserProfile() async {
    // return user profile from database
  }

  Future getChats() async {
    // return list of chats from database
  }

  Future getMessages(chatId) async {
    // return list of messages for currently selected chat room
  }
}
