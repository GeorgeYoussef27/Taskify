import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskify/firestore/FirestoreHandler.dart';
import 'package:taskify/firestore/model/Task.dart';
import 'package:taskify/ui/home/tabs/TasksTab/widgets/TaskItem.dart';

class TasksTab extends StatelessWidget {
  DateTime selectedDate;
  TasksTab(this.selectedDate);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirestoreHandler.GetTasksListen(FirebaseAuth.instance.currentUser!.uid,selectedDate),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(snapshot.hasError){
            return Column(
              children: [
                Text(snapshot.error!.toString()),
              SizedBox(height: 10,),
              ElevatedButton(
                  onPressed: (){},
                  child: Text("Try Again"))
              ],
            );
          }
          List<Task> tasks = snapshot.data??[];
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(height: 20,),
                itemCount: tasks.length,
                itemBuilder: (context, index) => TaskItem(task: tasks[index])
            ),
          );
        },
    );
  }
}
