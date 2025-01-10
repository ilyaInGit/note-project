import 'package:flutter_application_1/task_type.dart';
import 'package:flutter_application_1/type_enum.dart';

List<TaskType> getTaskTypeList() {
  var List = [
    TaskType(
        image: 'images/hard_working.png',
        title: 'کار',
        taskTypeEnum: TaskTypeEnum.working),
    TaskType(
        image: 'images/banking.png',
        title: 'بانک',
        taskTypeEnum: TaskTypeEnum.bank),
    TaskType(
        image: 'images/meditate.png',
        title: 'تمرکز',
        taskTypeEnum: TaskTypeEnum.focus),
    TaskType(
        image: 'images/social_frends.png',
        title: 'قرار',
        taskTypeEnum: TaskTypeEnum.date),
    TaskType(
        image: 'images/workout.png',
        title: 'ورزش',
        taskTypeEnum: TaskTypeEnum.workout),
    TaskType(
        image: 'images/work_meeting.png',
        title: 'جلسه',
        taskTypeEnum: TaskTypeEnum.session),
  ];

  return List;
}
