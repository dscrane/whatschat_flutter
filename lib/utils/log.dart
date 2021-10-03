const String red = '\x1b[31m';
const String green = '\x1b[32m';
const String yellow = '\x1b[33m';
const String blue = '\x1b[34m';
const String cyan = '\x1b[36m';
const String magenta = '\x1b[95m';
const String white = '\x1b[97m';
const String reset = '\x1b[0m';

class Log {
  static void io({data = "", log, data2 = ""}) {
    print('\x1b[33m[SOCKET]: ${'\x1b[32m$data'} $log ${'\x1b36m$data2'}');
  }

  static void room({roomId, log, data = ""}) {
    print('[${'\x1b[36m$roomId'}]: ${log}');
    print(data);
  }

  static void ack(data) {
    if (data != null) {
      print('$magenta[IO_ack]: $white${data[0]} $yellow${data[1]} $green${data[2]} $reset');
    } else {
      print('$magenta[IO_ack]: $red Acknowledgement failed');
    }
  }
}
