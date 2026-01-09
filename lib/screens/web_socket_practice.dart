import 'package:firebase_tutorial/services/web_socket_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebSocketPractice extends StatelessWidget {
  const WebSocketPractice({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final controller = Get.put(WebSocketService());
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(()=> Text(controller.string.value)),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: textController,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          MaterialButton(
            onPressed: ()=>controller.sendMessage(textController.text),
            color: Colors.deepPurple,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Text('Send'),
          )
        ],
      ),
    );
  }
}
