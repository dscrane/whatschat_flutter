const String red = '\x1b[31m';
const String green = '\x1b[32m';
const String yellow = '\x1b[33m';
const String blue = '\x1b[34m';
const String cyan = '\x1b[36m';
const String magenta = '\x1b[95m';
const String white = '\x1b[97m';
const String reset = '\x1b[0m';

class Log {
  static void emit(data) {
    print('$magenta[IO_emit]: $yellow${data[0]} $white${data[1]} $reset');
  }

  static void room({roomId, log, data = ""}) {
    print('[${'\x1b[36m$roomId'}]: ${log}');
    print(data);
  }

  static void ack(data) {
    if (data != null) {
      print('$magenta[IO_ack]: $yellow${data[0]} $white${data[1]} $green${data[2]} $reset');
    } else {
      print('$magenta[IO_ack]: $red Acknowledgement failed');
    }
  }
}
