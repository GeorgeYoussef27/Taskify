import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskify/firestore/FirestoreHandler.dart';
import 'package:taskify/firestore/model/Task.dart';
import 'package:taskify/style/constants.dart';
import 'package:taskify/style/reusable_components/CustomAlertDialog.dart';
import 'package:taskify/style/reusable_components/CustomFormField.dart';
import 'package:taskify/style/reusable_components/CustomLoadingDialog.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descriptionController = TextEditingController();
  }
  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Form(
      key: formKey,
      child: Padding(
        padding:  EdgeInsets.only(
          top: 16,
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Add New Task",
            style: Theme.of(context).textTheme.titleSmall,),
            SizedBox(height: height*0.02,),
            CustomFormField(
                label: "Enter The Task Title",
                keyboard: TextInputType.text,
                validate: (value){
                  if(value==null || value.isEmpty){
                    return "Please enter the title of task ";
                  }
                  return null;
                },
                controller: titleController
            ),
            SizedBox(height: height*0.02,),
            CustomFormField(
                label: "Enter The Task Description",
                keyboard: TextInputType.text,
                validate: (value){
                  if(value==null || value.isEmpty){
                    return "Please enter the description of task ";
                  }
                  return null;
                },
                controller: descriptionController
            ),
            SizedBox(height: height*0.02,),
            TextButton(
              onPressed: (){
                showTaskDate();
              },
                child: Text(
                  selectedDate==null
                      ?"Select Date"
                      :DateFormat.yMMMd().format(selectedDate!),
                  style: TextStyle(
                  fontSize: 15
                ),)
            ),
            SizedBox(height: height*0.04,),
            ElevatedButton(
                onPressed: (){
                  AddNewTask();
                },
                child: Text("Add Task"))
          ],
        ),
      ),
    );
  }
  DateTime? selectedDate;
  showTaskDate()async{
    var date = await showDatePicker(
        context: context,
        initialDate: selectedDate??DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(
          days: 365,
        ))
    );
    setState(() {
      selectedDate = date;
    });
  }
  AddNewTask() async {
    if(formKey.currentState!.validate()){
      if(selectedDate!=null){
        showDialog(context: context, builder: (context) => CustomLoadingDialog(),);
        await FirestoreHandler.createTask(Task(
          title: titleController.text,
          description: descriptionController.text,
          date: Timestamp.fromMillisecondsSinceEpoch(selectedDate!.millisecondsSinceEpoch),
        ), FirebaseAuth.instance.currentUser!.uid);
        Navigator.pop(context);
        showDialog(context: context, builder: (context) => CustomAlertDialog(
            dialogLabel: "Task created successfully",
            positiveBtnPress: (){
              Navigator.pop(context);
            }
        ),);
      }else{
        showToast("Please select task date");
      }
    }
  }
}
