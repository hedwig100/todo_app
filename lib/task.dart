import "package:flutter/material.dart";
import "package:hive/hive.dart";
part "task.g.dart";

@HiveType(typeId: 1)
class Task extends Object {
  @HiveField(0)
  String taskName;

  @HiveField(1)
  DateTime deadline;

  @HiveField(2)
  bool isDone;

  @HiveField(3)
  bool isImportant = false;

  @HiveField(4)
  String memo = "";

  Task(this.taskName, this.deadline, this.isDone);
}
