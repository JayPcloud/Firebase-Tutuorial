import 'package:firebase_tutorial/routers/app_router.dart';
import 'package:firebase_tutorial/services/auth_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController{

  final _auth = Get.put(AuthService());

  void logout() async{
    await _auth.logout();
    Get.offAllNamed(AppRouter.wrapper);
  }

}