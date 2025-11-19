import 'package:firebase_tutorial/controllers/signup_controller.dart';
import 'package:firebase_tutorial/routers/app_router.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}
    
class _SignupScreenState extends State<SignupScreen> {

  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();
 
  final formKey = GlobalKey<FormState>();
 final controller = Get.put(SignupController());


  @override
  void dispose() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmPassCtrl.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('SignUp',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 30),
                //Email TextField
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    TextFormField(
                      controller: emailCtrl,
                      validator: (value) =>
                          controller.emailValidator(value ?? ''),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Password TextField
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text(
                      'Password',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    TextFormField(
                      controller: passwordCtrl,
                      validator: (value) =>
                          controller.passValidator(value ?? ''),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                    ),
                  ],
                ),

                SizedBox(
                  height: 20,
                ),

                // Confirm Password TextField
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 10,
                  children: [
                    Text(
                      'Confirm Password',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    TextFormField(
                      controller: confirmPassCtrl,
                      validator: (value) => controller.confirmPassValidator(
                          passwordCtrl.text, value??''),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                    ),
                  ],
                ),

                SizedBox(height: 30),

                 Obx(
                   ()=> MaterialButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : () {
                                if (formKey.currentState?.validate() ?? false) {
                                  controller.signUp(
                                      emailCtrl.text, passwordCtrl.text);
                                }
                              },
                        color: Colors.deepPurple,
                        disabledColor: Colors.grey,
                        minWidth: double.infinity,
                        height: 52,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: controller.isLoading.value ==true
                            ? SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ))
                            : Text('SignUp')),
                 ),
                

                SizedBox(height: 10),
                Row(spacing: 5, children: [
                  Text('Already have an account?'),
                  InkWell(
                      onTap: () {
                        Get.offAllNamed(AppRouter.login);
                      },
                      child: Text('Login',
                          style: TextStyle(
                              color: Colors.deepPurple,
                              fontWeight: FontWeight.w600)))
                ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
