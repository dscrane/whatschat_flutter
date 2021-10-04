class Message {
  String _id;
  String _author;
  String _authorId;
  String _roomName;
  String _message;
  DateTime _timestamp;
  bool _isUnread;

  Message(
    this._id,
    this._author,
    this._authorId,
    this._roomName,
    this._message,
    this._timestamp,
    this._isUnread,
  );

  Message.fromSocket(Map<String, dynamic> message)
      : this._id = message['_id'],
        this._author = message['author'],
        this._authorId = message['userId'],
        this._roomName = message['chatroomName'],
        this._message = message['message'],
        this._timestamp = DateTime.parse(message['createdAt']),
        this._isUnread = message['isUnread'] ?? true;

  String get id => _id;
  String get author => _author;
  String get authorId => _authorId;
  String get roomName => _roomName;
  String get message => _message;
  DateTime get timestamp => _timestamp;
  bool get isUnread => _isUnread;
}
