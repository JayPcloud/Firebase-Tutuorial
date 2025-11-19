import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_tutorial/models/user_model.dart';

class UserRepository {

  final _db = FirebaseFirestore.instance;
  
  Future<void> addUser(UserModel user) async{
    await _db.collection('users').doc(user.id).set(user.toFirestore());
  }


}