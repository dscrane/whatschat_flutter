import 'package:socket_io_client/socket_io_client.dart';

class SocketController {
  static Socket socket = io('http://192.168.1.32:5500',
      OptionBuilder().setTransports(['websocket']).disableAutoConnect().build());
}
