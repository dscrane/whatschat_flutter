class SocketException implements Exception {
  String type;
  String name;
  String message;
  String data;

  SocketException(error)
      : this.type = error['type'],
        this.name = error['name'],
        this.message = error['message'],
        this.data = error['data'] ?? '';

  @override
  String toString() {
    return '$type: $message $data';
  }
}

class ServerException implements Exception {
  String type;
  String name;
  String message;
  String data;

  ServerException(error)
      : this.type = error['type'],
        this.name = error['name'],
        this.message = error['message'],
        this.data = error['data'] ?? '';

  @override
  String toString() {
    return '$type: $message $data';
  }
}
