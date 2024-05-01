import 'dart:convert';

import 'package:web_socket_channel/io.dart';

class WebSocketManager {
  final String serverUrl;
  IOWebSocketChannel? _channel;
  Function(dynamic) onData;
  Function(dynamic) onError;
  Function() onConnected;
  Function() onDisconnected;

  WebSocketManager({
    required this.serverUrl,
    required this.onData,
    required this.onError,
    required this.onConnected,
    required this.onDisconnected,
  });

  void connect() {
    _channel = IOWebSocketChannel.connect(serverUrl);
    _channel!.stream.listen(
      (data) {
        try {
          print(data);
        } catch (error) {
          print("Error");
        }
        onData(data);
      },
      onError: (error) {
        onError(error);
      },
      onDone: () {
        onDisconnected();
      },
      cancelOnError: true,
    );

    onConnected();
  }

  void disconnect() {
    print("Disconnected!!!");
    _channel!.sink.close();
  }

  void sendMessage(Map<String, dynamic> message) {
    _channel!.sink.add(json.encode(message));
  }
}
