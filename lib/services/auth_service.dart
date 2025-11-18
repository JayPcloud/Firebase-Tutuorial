import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService extends GetxService{

  final _auth = FirebaseAuth.instance;

  Future<User?> signUp(String email, String password) async {
    try {
    final userCredential = await _auth.createUserWithEmailAndPassword(
      email: email, 
      password: password
      );
      return userCredential.user;
    } on FirebaseAuthException catch(e) {
      print(e.toString());
      throw Exception(e.message);
    }
  }

  Future<User?> login(String email, String password) async {
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
      email: email, 
      password: password
      );

    return userCredential.user;
    } catch(e) {
      print(e.toString());
      throw Exception(e.toString());
    }
  }

  Future<void> logout() async {
    await _auth.signOut(); 
  }
  

}