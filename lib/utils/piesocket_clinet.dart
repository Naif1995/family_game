import 'package:piesocket_channels/channels.dart';

class PieSocketClinet {
  late PieSocket piesocket;
  static PieSocketClinet? _instance;

  PieSocketClinet._internal() {
    var options = PieSocketOptions();
    options.setClusterId("s8304.lon1");
    options.setApiKey("X5IfwVVnSHeOXfqm8aERkRpsG6G6ZaqKnXIdzI97");
    // options.setForceAuth(true);
    options.setAuthEndpoint("https://www.piesocket.com/test");
    options.setPresence(true);

    var headers = {"Client": "tetsdk"};
    options.setAuthHeaders(headers);
    piesocket = PieSocket(options);
  }

  static PieSocketClinet get instance {
    _instance ??= PieSocketClinet._internal();
    return _instance!;
  }
}
