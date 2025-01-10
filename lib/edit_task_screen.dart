import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Home_screen.dart';
import 'package:flutter_application_1/task.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:time_pickerr/time_pickerr.dart';

class EditTaskScreen extends StatefulWidget {
  EditTaskScreen({super.key, required this.task});

  Task task;

  @override
  State<EditTaskScreen> createState() => _EditTaskScreenState();
}

class _EditTaskScreenState extends State<EditTaskScreen> {
  FocusNode negahban1 = FocusNode();
  FocusNode negahban2 = FocusNode();

  TextEditingController? controllerTaskTitle;
  TextEditingController? controllerTaskSubTitle;

  DateTime? tasktime;

  final box = Hive.box<Task>('taskBox');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controllerTaskTitle = TextEditingController(text: widget.task.title);
    controllerTaskSubTitle = TextEditingController(text: widget.task.subTitle);

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
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  controller: controllerTaskTitle,
                  focusNode: negahban1,
                  decoration: InputDecoration(
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
                          color: Color.fromARGB(255, 96, 157, 255), width: 3.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        width: 3,
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
                  style: TextStyle(
                    color: Colors.white,
                  ),
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
                          color: Color.fromARGB(255, 96, 157, 255), width: 3.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      borderSide: BorderSide(
                        width: 3,
                        color: Color.fromARGB(255, 96, 157, 255),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
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
            Spacer(),
            Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 96, 157, 255),
                  minimumSize: Size(200, 40),
                ),
                onPressed: () {
                  String taskTitle = controllerTaskTitle!.text;
                  String taskSTitle = controllerTaskSubTitle!.text;
                  editTask(taskTitle, taskSTitle, tasktime!);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'ویرایش تسک',
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

  editTask(String taskTitle, String taskSTitle, DateTime taskTime) {
    widget.task.title = taskTitle;
    widget.task.subTitle = taskSTitle;
    widget.task.time = taskTime;

    widget.task.save();
  }
}
