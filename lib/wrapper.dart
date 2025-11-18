import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/screens/home_screen.dart';
import 'package:firebase_tutorial/screens/login_screen.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(), 
      builder: (context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if(snapshot.data == null) {
          return LoginScreen();
        }
        return HomeScreen();
      },
      );
  }
}