import 'package:firebase_tutorial/routers/app_router.dart';
import 'package:firebase_tutorial/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController{

  final _auth = Get.put(AuthService());

  String? emailValidator(String email) {
    final value = email.trim();
    if (value.isEmpty) {
      return "Email field can't be empty";
    }

    // Basic, pragmatic email regex — covers common cases without being excessively strict
    final pattern = r'^[\w.-]+@([\w-]+.)+[\w-]{2,}$';
    final regExp = RegExp(pattern);

    if (!regExp.hasMatch(value)) {
      return 'Enter a valid email address';
    }
  }

  String? passValidator(String input) {
    if(input.trim().isEmpty) {
      return "Password Can't be empty";
    }
  }

  void login(String email, String password, BuildContext context) async {
    try{
      showDialog(
        context: context, 
        barrierDismissible: false,
        builder: (context)=> Center(child: CircularProgressIndicator())
        );
     final user = await _auth.login(email, password);
     print(user?.email);
     Get.back();
     Get.showSnackbar(
        GetSnackBar(
          message: 'Login Successful. Please login',
          duration: Duration(seconds: 3),
        ),
      );
      Get.offAllNamed(AppRouter.wrapper);
    } catch(e) {
      Get.back();
      Get.showSnackbar(
        GetSnackBar(
          message: e.toString(),
        ),
      );
    }
  }

}