import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/models/task_model.dart';


class TasksRepository {

  final _db = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser;

  Future<void> createTask(TaskModel task) async {
    await _db.collection('users').doc(currentUser?.uid).collection('Tasks')
    .add(
      task.toFirestore()
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getUsersTasks() {
    return _db.collection('users').doc(currentUser?.uid).collection('Tasks').orderBy('is_completed',).orderBy('created_at', descending: true).snapshots();
  } 

  Future<void> updateTask(String taskDocId, Map<String, dynamic> data) async{
    await _db.collection('users').doc(currentUser?.uid).collection('Tasks').doc(taskDocId).update(
      data  
    );
  }

  Future<void> deleteTask(String taskDocId) async{
    await _db.collection('users').doc(currentUser?.uid).collection('Tasks').doc(taskDocId).delete();
  }


}