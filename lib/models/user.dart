class User {
  String _id;
  String _username;
  String _name;
  String? _email;
  List<String> _rooms;
  String _avatar;
  String _token;

  User(
    this._id,
    this._username,
    this._name,
    this._avatar,
    this._rooms,
    this._token,
  );

  User.fromJsoN(Map<String, dynamic> json, String token)
      : this._id = json['_id'],
        this._username = json['username'],
        this._name = json['name'],
        this._email = '${json['username']}@email.com',
        this._rooms = json['currentRooms'].map<String>((room) => room.toString()).toList(),
        this._token = token,
        this._avatar = json['avatar'];

  String get id => _id;
  String get token => _token;
  String get username => _username;
  String get name => _name;
  String? get email => _email;
  List<String> get rooms => _rooms;
  String get avatar => _avatar;
}
