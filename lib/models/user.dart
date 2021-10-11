class User {
  String _id;
  String _username;
  String _name;
  String? _email;
  List<String> _rooms;
  String _avatar;
  String? _token;

  User(
    this._id,
    this._username,
    this._name,
    this._avatar,
    this._rooms,
    this._token,
  );

  User.fromPreferences(Map<String, dynamic> pref)
      : this._id = pref['_id'],
        this._username = pref['username'],
        this._name = pref['name'],
        this._email = '${pref['username']}@email.com',
        this._rooms = pref['rooms'].toList().map<String>((room) => room.toString()).toList(),
        this._avatar = pref['avatar'],
        this._token = pref['token'];

  User.fromJson(Map<String, dynamic> json, String token)
      : this._id = json['_id'],
        this._username = json['username'],
        this._name = json['name'],
        this._email = '${json['username']}@email.com',
        this._rooms = json['currentRooms'].map<String>((room) => room.toString()).toList(),
        this._avatar = json['avatar'],
        this._token = token;

  String get id => _id;
  String? get token => _token;
  String get username => _username;
  String get name => _name;
  String? get email => _email;
  List<String> get rooms => _rooms;
  String get avatar => _avatar;

  Map<String, dynamic> toJson() => {
        "_id": _id,
        "username": _username,
        "name": _name,
        "avatar": _avatar,
        "rooms": _rooms,
        "token": _token,
      };
}
