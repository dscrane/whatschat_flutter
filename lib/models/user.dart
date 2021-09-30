class User {
  String id;
  String username;
  String name;
  List rooms;
  String avatar;

  User({
    required this.id,
    required this.username,
    required this.name,
    required this.avatar,
    required this.rooms,
  });

  User.fromJsoN(Map<String, dynamic> json)
      : this.id = json['_id'],
        this.username = json['username'],
        this.name = json['name'],
        this.rooms = json['currentRooms'],
        this.avatar = json['avatar'];
}
