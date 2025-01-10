import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/add_task_screen.dart';
import 'package:flutter_application_1/task.dart';
import 'package:flutter_application_1/task_widget.dart';
import 'package:hive_flutter/adapters.dart';
// import 'package:msh_checkbox/msh_checkbox.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool isFabvisible = true;

  bool isChecked = false;
  String inputText = '';
  var controller = TextEditingController();

  var box = Hive.box('names');
  var studentBox = Hive.box('studentBox');

  var taskBox = Hive.box<Task>('taskBox');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "what ",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              "ToDo",
              style: TextStyle(
                  color: Color.fromARGB(255, 96, 157, 255),
                  fontWeight: FontWeight.w700),
            ),
            Text(
              " today",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 30, 3, 43),
      body: Center(
        child: Container(
          child: ShaderMask(
            shaderCallback: (Rect rect) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.purple,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.purple
                ],
                stops: [
                  0.0,
                  0.0,
                  0.78,
                  1.0,
                ], // 10% purple, 80% transparent, 10% purple
              ).createShader(rect);
            },
            blendMode: BlendMode.dstOut,
            child: ValueListenableBuilder(
              valueListenable: taskBox.listenable(),
              builder: (BuildContext context, dynamic value, Widget? child) {
                return NotificationListener<UserScrollNotification>(
                  onNotification: (notif) {
                    setState(() {
                      if (notif.direction == ScrollDirection.forward) {
                        isFabvisible = true;
                      }
                      if (notif.direction == ScrollDirection.reverse) {
                        isFabvisible = false;
                      }
                    });

                    return true;
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.only(bottom: 90),
                    itemCount: taskBox.values.length,
                    itemBuilder: ((context, index) {
                      var task = taskBox.values.toList()[index];
                      return getListItem(task);
                    }),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: AvatarGlow(
        glowCount: 2,
        glowRadiusFactor: 0.8,
        child: FloatingActionButton(
          splashColor: Colors.amber,
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return AddTaskScreen();
            }));
          },
          backgroundColor: Color.fromARGB(255, 38, 248, 49),
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
        glowColor: Color.fromARGB(255, 38, 248, 49),
        duration: Duration(milliseconds: 2000),
        // repeat: true,
      ),
    );
  }

  Widget getListItem(Task task) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        task.delete();
      },
      child: TaskWidget(task: task),
    );
  }
}

void printing(dynamic obj) {
  print(obj.name);
  print(obj.family);
  print(obj.age);
  print(obj.grade);
}
