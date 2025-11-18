import 'package:firebase_tutorial/screens/login_screen.dart';
import 'package:firebase_tutorial/screens/signup_screen.dart';
import 'package:firebase_tutorial/wrapper.dart';
import 'package:get/get.dart';

class AppRouter {

  static List<GetPage> pages = [
     GetPage(name: wrapper, page: () => Wrapper(),),
    GetPage(name: signup, page: () => SignupScreen(),),
    GetPage(name: login, page: () => LoginScreen(),),
  ];

  static const wrapper = '/wrapper';
  static const signup = '/signup';
  static const login = '/login';

}