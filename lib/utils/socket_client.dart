import 'package:socket_io_client/socket_io_client.dart';

class SocketClient {
  static SocketClient? _instance;
  Socket? socket;

  SocketClient._internal() {
    socket = io(
        'http://localhost:3000',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .build());
    socket?.connect();
  }

  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
