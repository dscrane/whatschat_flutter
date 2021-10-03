class User {
  String _id;
  String _username;
  String _name;
  List<String> _rooms;
  String _avatar;

  User(
    this._id,
    this._username,
    this._name,
    this._avatar,
    this._rooms,
  );

  User.fromJsoN(Map<String, dynamic> json)
      : this._id = json['_id'],
        this._username = json['username'],
        this._name = json['name'],
        this._rooms = json['currentRooms'].map<String>((room) => room.toString()).toList(),
        this._avatar = json['avatar'];

  String get id => _id;
  String get username => _username;
  String get name => _name;
  List<String> get rooms => _rooms;
  String get avatar => _avatar;
}
