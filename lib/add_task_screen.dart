import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Home_screen.dart';
import 'package:flutter_application_1/task.dart';
import 'package:flutter_application_1/task_type.dart';
import 'package:flutter_application_1/utility.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:time_pickerr/time_pickerr.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  int _selectedTaskTypeitem = 0;

  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();

  final TextEditingController controllerTaskTitle = TextEditingController();
  final TextEditingController controllerTaskSubTitle = TextEditingController();

  final box = Hive.box<Task>('taskBox');

  DateTime? tasktime;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    negahban1.addListener(() {
      setState(() {});
    });

    negahban2.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 30, 3, 43),
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            SizedBox(height: 50),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 44),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: controllerTaskTitle,
                  focusNode: negahban1,
                  decoration: InputDecoration(
                    fillColor: const Color.fromARGB(255, 244, 188, 188),
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    labelText: 'عنوان تسک',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: negahban1.hasFocus
                          ? Color(0xff18DAA3)
                          : Color.fromARGB(255, 96, 157, 255),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 96, 157, 255), width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        width: 2,
                        color: Color(0xffF35383),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 44),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: controllerTaskSubTitle,
                  maxLines: 2,
                  focusNode: negahban2,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                    labelText: 'توضیحات تسک',
                    labelStyle: TextStyle(
                      fontSize: 20,
                      color: negahban2.hasFocus
                          ? Color(0xff18DAA3)
                          : Color.fromARGB(255, 96, 157, 255),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 96, 157, 255), width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        width: 2,
                        color: Color(0xffF35383),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomHourPicker(
              title: "              Enter hour and minute",
              titleStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
              negativeButtonText: "حذف",
              positiveButtonText: "تایید",
              negativeButtonStyle: TextStyle(
                color: Color.fromARGB(255, 183, 8, 8),
                fontWeight: FontWeight.bold,
              ),
              positiveButtonStyle: TextStyle(
                color: Color.fromARGB(255, 12, 173, 95),
                fontWeight: FontWeight.bold,
              ),
              onNegativePressed: (context) {},
              onPositivePressed: (context, time) {
                tasktime = time;
              },
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Container(
                height: 130,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: getTaskTypeList().length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedTaskTypeitem = index;
                        });
                      },
                      child: TaskTypeItemList(
                        index: index,
                        selectedItemList: _selectedTaskTypeitem,
                        taskType: getTaskTypeList()[index],
                      ),
                    );
                  },
                ),
              ),
            ),
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 96, 157, 255),
                  minimumSize: Size(200, 50),
                ),
                onPressed: () {
                  String taskTitle = controllerTaskTitle.text;
                  String taskSTitle = controllerTaskSubTitle.text;
                  addTask(taskTitle, taskSTitle, tasktime!);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Add',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  addTask(String taskTitle, String taskSTitle, DateTime time) {
    //add a Task
    var task = Task(
      title: taskTitle,
      subTitle: taskSTitle,
      time: time,
    );

    //we used box.add instead , box.put for auto incrementing index of new task

    box.add(task);
    // print(box.get(2)!.title);
  }
}

// ignore: must_be_immutable
class TaskTypeItemList extends StatelessWidget {
  TaskTypeItemList({
    super.key,
    required this.taskType,
    required this.index,
    required this.selectedItemList,
  });

  TaskType taskType;

  int index;
  int selectedItemList;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        // color: Colors.green,
        border: Border.all(
          color:
              (selectedItemList == index) ? Colors.green : Colors.transparent,
          width: 2,
        ),

        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.asset(taskType.image),
          SizedBox(
            height: 5,
          ),
          Text(
            taskType.title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
