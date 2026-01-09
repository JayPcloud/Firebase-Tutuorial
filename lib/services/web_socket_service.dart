import 'dart:async';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService extends GetxController {
    WebSocketChannel? _webSocketChannel;
    Timer? _timer;
    RxString string = ''.obs;

    void connect() {

      _webSocketChannel ??= WebSocketChannel.connect(
        Uri.parse('wss://ws.postman-echo.com/raw'), 
      );

      _webSocketChannel?.stream.listen(
        (event) {
          print('sent');
          string.value = event;
        },
        onError: (err)=>_handleReconnect(),
        onDone: ()=> _handleReconnect(),
      );
    }

  void _startHeartBeat() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 20), (e)=> _webSocketChannel?.sink.add({"type":"ping"}));
  }
  
  void _handleReconnect() {
    Future.delayed(Duration(seconds: 5), ()=> connect());
  }

  void sendMessage(String message) {
    _webSocketChannel?.sink.add(message);
  }


  @override
  void onInit() {
    connect();
    _startHeartBeat();
    
    super.onInit();
  }

  @override
  void onClose() {
    _webSocketChannel?.sink.close();
    super.onClose();
  }
}