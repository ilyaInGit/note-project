import 'package:hive_flutter/adapters.dart';

@HiveType(typeId: 4)
class TaskType {
  TaskType(
      {required this.image, required this.title, required this.taskTypeEnum});

  @HiveField(0)
  String image;

  @HiveField(1)
  String title;

  @HiveField(2)
  Enum taskTypeEnum;
}
