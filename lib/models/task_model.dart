import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  String? id;
  String description;
  Timestamp? timeStamp;
  bool isCompleted;

  TaskModel({
    this.id,
    required this.description,
    this.timeStamp,
    required this.isCompleted
  });

  factory TaskModel.fromFirestore(QueryDocumentSnapshot<Map<String, dynamic>> data) {
    return TaskModel(
      id: data.id,
      description: data['description'], 
      isCompleted: data['is_completed']
      );
  } 

  Map<String, dynamic> toFirestore() {
    Map<String, dynamic> map = {};
    map['description']=description;
    map['created_at']=FieldValue.serverTimestamp();
    map['is_completed']=isCompleted;

   return map;
}

}