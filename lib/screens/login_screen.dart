import 'package:firebase_tutorial/controllers/login_controller.dart';
import'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routers/app_router.dart';

class LoginScreen extends StatelessWidget {
    const LoginScreen({super.key});


@override
Widget build(BuildContext context) {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final formKey = GlobalKey<FormState>();

  final controller = Get.put(LoginController());
    return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15,),
            child: Form(
              key: formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      Text('Login', style:TextStyle(fontSize: 18, fontWeight:FontWeight.bold)),
                      SizedBox(height:30),
                      //Email TextField
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          Text('Email', style: TextStyle(fontSize: 14,),),
                          TextFormField(
                            controller: emailCtrl,
                            validator: (value)=>controller.emailValidator(value??''),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                  )
                              ),
                          ),
                        ],
                      ),
                        
                      SizedBox(height: 20),
                        
                      // Password TextField
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 10,
                        children: [
                          Text('Password', style: TextStyle(fontSize: 14,),),
                          TextFormField(
                            controller: passCtrl,
                            validator: (value) => controller.passValidator(value??''),
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                  )
                              ),
                          ),
                        ],
                      ),
                        
                      SizedBox(height:30),
                      
                      MaterialButton(
                        onPressed: (){
                          if(formKey.currentState?.validate()??false) {
                            controller.login(emailCtrl.text.trim(), passCtrl.text.trim(), context);
                          }
                        },
                        color: Colors.deepPurple,
                        minWidth: double.infinity,
                        height: 52,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                        child: Text('Login')
                      ),
              
                  SizedBox(height:10),
                  Row(
                    spacing:5,
                    children:[
                      Text('Not a user yet?'),
                      InkWell(
                        onTap:(){
                          Get.offAllNamed(AppRouter.signup);
                        },
                        child: Text('Signup', style:TextStyle(color:Colors.deepPurple, fontWeight:FontWeight.w600))
                      )
                    ]
                  )
                        
                  ],
              ),
            ),
          ),
        ),
    );
}

}