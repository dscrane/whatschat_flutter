class Message {
  String id;
  String createdBy;
  String messageText;
  bool isUnread;

  Message({
    required this.id,
    required this.createdBy,
    required this.messageText,
    this.isUnread = false,
  });
}
