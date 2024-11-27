import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskify/ui/home/tabs/SettingsTab/SettingsTab.dart';
import 'package:taskify/ui/home/tabs/TasksTab/TasksTab.dart';
import 'package:taskify/ui/home/widgets/AddTaskBottomSheet.dart';
import 'package:taskify/ui/login/login_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;



  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(
          side: BorderSide(
            color: Colors.white,
            width: 4
          )
        ),
          onPressed: (){
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (context) => AddTaskBottomSheet());
          },
          child: Icon(Icons.add),
          ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 15,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index){
            setState(() {
              selectedIndex = index;
            });
          },
          backgroundColor: Colors.transparent,
            elevation: 0,
            items: [
              BottomNavigationBarItem(icon:Icon(
                Icons.list
              ),label: ""),
              BottomNavigationBarItem(icon:Icon(
                  Icons.settings,
              ),label: "")
            ]
        ),
      ),
      body: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            clipBehavior: Clip.none,
            children: [
              AppBar(
                title: Text("Tasks List",),
                actions: [
                  IconButton(onPressed: (){
                    FirebaseAuth.instance.signOut();
                    Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false,);
                  },
                      icon: Icon(
                          Icons.logout
                      )),
                ],
              ),
              Visibility(
                visible: selectedIndex==0,
                child: Positioned(
                  bottom: -40,
                  left: 0,
                  right: 0,
                  child: EasyInfiniteDateTimeLine(
                    showTimelineHeader: false,
                    dayProps: EasyDayProps(
                      width: 58,
                      height: 79,
                      todayStyle:DayStyle(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                      ) ,
                      inactiveDayStyle: DayStyle(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    firstDate: DateTime.now(),
                    focusDate: selectedDate,
                    lastDate: DateTime.now().add(Duration(days: 365)),
                    onDateChange: (newDate) {
                      setState(() {
                        selectedDate = newDate;
                      });
                    },
                  ),
                ),
              )
            ],
          ),
          Expanded(child: selectedIndex==0
              ?TasksTab(selectedDate)
              :SettingsTab()),
        ],
      ),
    );
  }
}
