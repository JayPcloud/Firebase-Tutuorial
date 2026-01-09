import 'package:firebase_tutorial/routers/app_router.dart';
import 'package:firebase_tutorial/screens/web_socket_practice.dart';
import 'package:firebase_tutorial/services/firebase_messaging_service.dart';
import 'package:firebase_tutorial/services/local_notifications_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final localNotificationService = LocalNotificationsService.instance();
  await localNotificationService.init();

  final firebaseMessagingService = FirebaseMessagingService.instace();
  await firebaseMessagingService.init(localNotificationService: localNotificationService);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // getPages: AppRouter.pages,
      debugShowCheckedModeBanner: false,
      // initialRoute: AppRouter.wrapper,
      home: WebSocketPractice(),
    );
  }
}
