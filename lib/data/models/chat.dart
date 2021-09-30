import 'user.dart';
import 'message.dart';

class Chat {
  String id;
  List<Message> messages;
  User user;
  int? unreadMessages;
  String? lastReadMessage;

  Chat({
    required this.id,
    required this.user,
    this.lastReadMessage,
    this.unreadMessages,
    this.messages = const [],
  });
}
