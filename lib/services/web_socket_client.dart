import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketClient {
  final WebSocketChannel channel = WebSocketChannel.connect(
      Uri.parse("ws://testpostulant.bioserenity.cloud:8080/openSocket"));
}
