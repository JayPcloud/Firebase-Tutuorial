import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String description;
  Timestamp? timeStamp;
  bool isCompleted;

  TaskModel({
    required this.description,
    this.timeStamp,
    required this.isCompleted
  });

  Map<String, dynamic> toFirestore() {
    Map<String, dynamic> map = {};
    map['description']=description;
    map['created_at']=FieldValue.serverTimestamp();
    map['is_completed']=isCompleted;

   return map;
}

}