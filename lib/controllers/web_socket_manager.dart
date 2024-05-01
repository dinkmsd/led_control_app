import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

final class WebSocketManager {
  final String serverUrl;
  late IO.Socket socket;

  WebSocketManager({
    required this.serverUrl,
  });

  void connect() {
    try {
      socket = IO
          .io(serverUrl,
              IO.OptionBuilder().setTransports(['websocket']).build())
          .connect();
      socket.onConnect((_) {
        debugPrint("Websocket connection success");
      });
    } catch (error) {
      debugPrint('$error');
    }
  }

  void disconnect() {
    socket.disconnect();
    socket.onDisconnect((_) => debugPrint("Websocket disconnected"));
  }

  void onMessage(String eventName, Function(dynamic) onEvent) {
    socket.on(eventName, (data) {
      onEvent(data);
    });
  }

  void sendMessage(String eventName, dynamic body) {
    socket.emit(eventName, body);
  }
}
