import 'package:flutter/material.dart';
import 'package:flutter_application_1/Home_screen.dart';
import 'package:flutter_application_1/add_task_screen.dart';
import 'package:flutter_application_1/task.dart';
import 'package:hive_flutter/adapters.dart';
import 'student.dart';

void main() async {
  await Hive
      .initFlutter(); //محلی مخصوص اپلیکیشن انتخاب میکنه تا دیتا رو اونجا ذخیره کنه
  await Hive.openBox('names');

  Hive.registerAdapter(StudentAdapter());
  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('taskBox');
  await Hive.openBox('studentBox');
  runApp(Application());
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'SM',
          textTheme: TextTheme(
              headlineMedium: TextStyle(
            fontFamily: 'SM',
          ))),
      debugShowCheckedModeBanner: false,
      home: Homescreen(),
    );
  }
}

//test for github commiting