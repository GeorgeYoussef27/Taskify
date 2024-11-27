import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:taskify/firestore/FirestoreHandler.dart';
import 'package:taskify/firestore/model/Task.dart';
import 'package:taskify/style/constants.dart';
import 'package:taskify/style/reusable_components/CustomAlertDialog.dart';
import 'package:taskify/style/reusable_components/CustomLoadingDialog.dart';

class TaskItem extends StatefulWidget {
  final Task task;
  const TaskItem({required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Slidable(
      startActionPane: ActionPane(
          motion: BehindMotion(),
          extentRatio: 0.2,
          children: [
            SlidableAction(
                onPressed: (context){
                  DeleteTask();
                },
              backgroundColor: Colors.redAccent,
              label: "Delete",
              icon: Icons.delete,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
              ),
            ),
          ]
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
            Container(
              width: 5,
              height: height * 0.08,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(
              width: width*0.07,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.task.title??"",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color:  Theme.of(context).colorScheme.primary
                  ),),
                  SizedBox(
                    height: 10,
                  ),
                  Text(widget.task.description??"",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontSize: 14,
                  ),)
                ],
              ),
            ),
            SizedBox(
              width: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
              ),
                onPressed: (){},
                child: Icon(Icons.check),
            ),
          ],
        ),
      ),
    );
  }

  DeleteTask(){
    showDialog(context: context, builder: (context) => CustomAlertDialog(
        dialogLabel: "Are you sure you want to delete this task?",
        positiveBtnTitle: "Yes",
        positiveBtnPress: () async {
          showDialog(context: context, builder: (context) => CustomLoadingDialog(),);
          await FirestoreHandler.DeleteTask(
              FirebaseAuth.instance.currentUser!.uid,
              widget.task.id??"");
          Navigator.pop(context);
          Navigator.pop(context);
          showToast("Task deleted successfully");
        },
      negativeBtnPress: (){
          Navigator.pop(context);
      },
      negativeBtnTitle: "No",
    ));

  }
}
