import 'package:whats_chat/models/message.dart';

String parseName(String name, currentUser) {
  if (currentUser == null) {
    return name;
  }
  List<String> names = name.split("_");
  names.retainWhere((element) => element != currentUser);
  print(names.join(""));
  return names.join('');
}

class Room {
  String _id;
  String _type;
  String _name;
  String _lastMessage;
  List<dynamic> _currentMembers;
  Map<String, dynamic> _instance;
  String? _createdBy;
  List<Message> _messages = [];
  late int _unreadMessages;

  Room(
    this._id,
    this._type,
    this._instance,
    this._name,
    this._messages,
    this._currentMembers,
    this._lastMessage,
    this._unreadMessages,
    this._createdBy,
  );

  Room.fromSocket(Map<String, dynamic> room, {String? currentUser})
      : this._id = room["_id"],
        this._type = room["type"],
        this._instance = room,
        this._name = parseName(room["name"], currentUser),
        this._currentMembers = room["currentMembers"],
        this._lastMessage = room["lastMessage"] != '' ? room["lastMessage"] : '* No Messages *',
        this._createdBy = room["createdBy"];

  String get id => _id;
  String get type => _type;
  String get name => _name;
  String? get createdBy => _createdBy;
  String get lastMessage => _lastMessage;
  int get unreadMessages => _unreadMessages;
  List<Message> get messages => _messages;
  List<dynamic> get currentMembers => _currentMembers;
  Map<String, dynamic> get instance => _instance;

  void set messages(List<Message> messages) => _messages = messages;

  void newMessage(Message message) => this.messages.add(message);
}
