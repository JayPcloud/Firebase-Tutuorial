import 'package:firebase_tutorial/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final formKey = GlobalKey<FormState>();
  final descTextController = TextEditingController();
  final controller = Get.put(HomeController());

  @override
  void dispose() {
    descTextController.dispose();
    formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
        actions: [
          IconButton(
            onPressed: ()=> controller.logout(),
            icon: Icon(Icons.logout)
            )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=>showTaskDialog(context),
        ),
      body: ListView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 10
            ),
            child: ListTile(
              minTileHeight: 80,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 10),
              tileColor: Colors.white,
              leading: Checkbox(value: true, onChanged: (value){},
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)
              ),
              ),
              title: Text('Task',maxLines: 2,),
            ),
          );
        },
        )
    );
  }

   void showTaskDialog(BuildContext context) {
    showDialog(
      context: context, 
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Add Tasks', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                SizedBox(height: 25,),
                Form(
                  key: formKey,
                  child: TextFormField(
                    maxLines: 3,
                    controller: descTextController,
                    decoration: InputDecoration(
                      hintText: 'Create New Task',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                MaterialButton(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  color: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)
                  ),
                  minWidth: double.infinity,
                  onPressed: () async{
                    if(formKey.currentState?.validate()??false) {
                     await controller.addTask(context,descTextController.text.trim());
                      descTextController.clear();
                    }
                  },
                  child: Text('Add Task'),
                  )
              ],
            ),
          ),
        );
      },
      );
  }
}