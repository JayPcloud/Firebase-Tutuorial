import 'package:firebase_tutorial/routers/app_router.dart';
import 'package:firebase_tutorial/services/auth_service.dart';
import 'package:get/get.dart';

class SignupController extends GetxController{
  
  final _auth = Get.put(AuthService());
  
  RxBool isLoading = false.obs;

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
    if(input.trim().length < 3) {
      return "Password must be more than 3 characters long";
    }
  }

  String? confirmPassValidator(String password, String confirmPassword) {
    if(password.trim() != confirmPassword.trim()) {
      return "Passwords don't match";
    }
  }

  void signUp(String email, String password) async {
    try {
      isLoading.value=true;
      await _auth.signUp(email, password);
      Get.showSnackbar(
        GetSnackBar(
          message: 'Registeration Successful. Please login',
          duration: Duration(seconds: 3),
        ),
      );
      isLoading.value=false;
      Get.offAllNamed(AppRouter.login);
    } catch(e) {
      isLoading.value=false;
       Get.showSnackbar(
        GetSnackBar(
          message: e.toString(),
        ),
      );
    }
  }
  
}