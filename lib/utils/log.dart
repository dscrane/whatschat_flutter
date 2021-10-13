const String red = '\x1b[31m';
const String green = '\x1b[32m';
const String bGreen = '\x1b[92m';
const String yellow = '\x1b[33m';
const String blue = '\x1b[34m';
const String cyan = '\x1b[36m';
const String magenta = '\x1b[35m';
const String bMagenta = '\x1b[95m';
const String white = '\x1b[97m';
const String reset = '\x1b[0m';

class Log {
  static void chatModel(data) {
    print('$yellow[CHATS]:$white $data');
  }

  static void sessionModel(data) {
    print('$yellow[SESSION]:$white $data');
  }

  static void provider(data) {
    print('$yellow[AUTH]:$white $data');
  }

  static void room({roomId, log, data = ""}) {
    print('[${'\x1b[36m$roomId'}]: ${log}');
    print(data);
  }

  static void emit(data) {
    print('$green[_EMIT_]: $yellow${data[0]} $white${data[1] ?? ""} $reset');
  }

  static void ack(data) {
    if (data != null) {
      print('$bGreen[_ACK_]: $yellow${data[0]} $white${data[1]} $bMagenta${data[2]} $reset');
    } else {
      print('$bGreen[_ACK_]: $red Acknowledgement failed');
    }
  }
}
