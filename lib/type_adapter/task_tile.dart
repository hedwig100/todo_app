import "package:flutter/material.dart";
import "package:hive/hive.dart";
import "package:todo_app/type_adapter/task.dart";
part "task_tile.g.dart";

@HiveType(typeId: 2)
class TaskTile extends Object {
  @HiveField(0)
  final IconData icon;

  @HiveField(1)
  final String listName;

  @HiveField(2)
  final List<Task> tasks;

  TaskTile(this.icon, this.listName, this.tasks);
}
