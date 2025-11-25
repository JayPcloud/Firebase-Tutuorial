import 'package:firebase_tutorial/models/task_model.dart';
import 'package:firebase_tutorial/routers/app_router.dart';
import 'package:firebase_tutorial/services/auth_service.dart';
import 'package:firebase_tutorial/services/tasks_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  final _auth = Get.put(AuthService());
  final taskRepo = Get.put(TasksRepository());


  Future<void> addTask(BuildContext context,String description)async {
    try{
      showDialog(
        context: context, 
        barrierDismissible: false,
        builder: (context)=> Center(child: CircularProgressIndicator())
        );
      final task = TaskModel(description: description, isCompleted: false);
      await taskRepo.createTask(task);
      Get.back();
      Get.back();
      showSnackBar('Task Created Successfully');
    }catch(e) {
      Get.back();
      Get.back();
       showSnackBar('Task Created Successfully');
    }


  }

  void markOrRemoveAsCompleted(String docId, bool isCompleted) async{
    try {
      await taskRepo.updateTask(docId, {'is_completed': isCompleted});
    } catch(e) {
      print(e.toString());
      showSnackBar('Failed to update task');
    }
  }

  void editTask(BuildContext context, String docId, String description) async{
    try {
      showDialog(
        context: context, 
        barrierDismissible: false,
        builder: (context)=> Center(child: CircularProgressIndicator())
        );
        await taskRepo.updateTask(docId, {
          'description' : description.trim()
        });
        Get.back();
        Get.back();
        showSnackBar('Task updated successfully');
    } catch(e) {
      Get.back();
      Get.back();
      showSnackBar('Error updating Task');
    }

  }

  void logout() async{
    await _auth.logout();
    Get.offAllNamed(AppRouter.wrapper);
  }

  void showSnackBar(String message) {
    Get.closeAllSnackbars();
    Get.showSnackbar(
        GetSnackBar(
          duration: Duration(seconds: 1),
          message: message,
        )
      );
  }

}