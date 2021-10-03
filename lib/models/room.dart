import 'package:whats_chat/models/message.dart';

class Room {
  String _id;
  String _name;
  String _lastMessage;
  List<dynamic> _currentMembers;
  Map<String, dynamic> _instance;
  String? _createdBy;
  List<Message> _messages = [];
  late int _unreadMessages;

  Room(
    this._id,
    this._instance,
    this._name,
    this._messages,
    this._currentMembers,
    this._lastMessage,
    this._unreadMessages,
    this._createdBy,
  );

  Room.fromSocket(Map<String, dynamic> room)
      : this._id = room["_id"],
        this._instance = room,
        this._name = room["name"],
        this._currentMembers = room["currentMembers"],
        this._lastMessage = room["lastMessage"],
        this._createdBy = room["createdBy"];

  String get id => _id;
  String get name => _name;
  String? get createdBy => _createdBy;
  String get lastMessage => _lastMessage;
  int get unreadMessages => _unreadMessages;
  List<Message> get messages => _messages;
  List<dynamic> get currentMembers => _currentMembers;
  Map<String, dynamic> get instance => _instance;

  void set messages(List<Message> messages) => _messages = messages;
}
