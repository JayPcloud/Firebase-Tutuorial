import 'package:firebase_tutorial/models/task_model.dart';
import 'package:firebase_tutorial/routers/app_router.dart';
import 'package:firebase_tutorial/services/auth_service.dart';
import 'package:firebase_tutorial/services/tasks_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  final _auth = Get.put(AuthService());
  final _taskRepo = Get.put(TasksRepository());


  Future<void> addTask(BuildContext context,String description)async {
    try{
      showDialog(
        context: context, 
        barrierDismissible: false,
        builder: (context)=> Center(child: CircularProgressIndicator())
        );
      final task = TaskModel(description: description, isCompleted: false);
      await _taskRepo.createTask(task);
      Get.back();
      showSnackBar('Task Created Successfully');
    }catch(e) {
      Get.back();
       showSnackBar('Task Created Successfully');
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