import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_tutorial/controllers/home_controller.dart';
import 'package:firebase_tutorial/models/task_model.dart';
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
                onPressed: () => controller.logout(), icon: Icon(Icons.logout))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => showTaskDialog(context, null),
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            stream: controller.taskRepo.getUsersTasks(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasData) {
                final data = snapshot.data?.docs;
                final tasks = data?.map((e) => TaskModel.fromFirestore(e),).toList();
                if(tasks?.isEmpty??true) {
                  return Center(child: Text('No task added yet'),);
                }
                return ListView.builder(
                  itemCount: tasks?.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 10),
                      child: ListTile(
                        minTileHeight: 80,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        tileColor: Colors.white,
                        leading: Checkbox(
                          value: tasks?[index].isCompleted,
                          onChanged: (value) {
                            controller.markOrRemoveAsCompleted(tasks?[index].id??'', value??false);
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                        ),
                        title: Text(
                          tasks?[index].description??'',
                          maxLines: 2,
                          style: TextStyle(
                           decoration: tasks?[index].isCompleted??false ?TextDecoration.lineThrough:null,
                          ),
                        ),
                        trailing: IconButton(
                          icon:Icon(Icons.edit_outlined),
                          onPressed: ()=> showTaskDialog(context, tasks?[index])
                        ),
                      ),
                    );
                  },
                );
              }
              if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Center(
                  child: Text('An Error occured : ${snapshot.error}'),
                );
              }
              return Center(
                child: Text('No data'),
              );
            }));
  }

  void showTaskDialog(BuildContext context, TaskModel? task) {
    final editDescTextCtrl = TextEditingController(text: task?.description);

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
                Text(
                  task!=null?'Edit Task':'Add Task',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 25,
                ),
                Form(
                  key: formKey,
                  child: TextFormField(
                    maxLines: 3,
                    controller: task!=null?editDescTextCtrl:descTextController,
                    decoration: InputDecoration(
                      hintText:  task!=null?'Edit description':'Create New Task',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                MaterialButton(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  color: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  minWidth: double.infinity,
                  onPressed: () async {
                    if(task != null) {
                       controller.editTask(context, task.id??'', editDescTextCtrl.text.trim());
                       editDescTextCtrl.clear();
                       return;
                    }
                    if (formKey.currentState?.validate() ?? false) {
                      await controller.addTask(
                          context, descTextController.text.trim());
                      descTextController.clear();
                    }
                  },
                  child: Text(task!=null?'Update Task':'Add Task'),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
