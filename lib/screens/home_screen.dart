import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: ()=> controller.logout(),
            icon: Icon(Icons.logout)
            )
        ],
      ),
      body: Center(
        child: Text('Home Page'),
      ),
    );
  }
}