import "package:hive/hive.dart";
import "package:todo_app/type_adapter/task.dart";
part "task_tile.g.dart";

@HiveType(typeId: 2)
class TaskTile extends HiveObject {
  @HiveField(0, defaultValue: "")
  final String listName;

  @HiveField(1, defaultValue: [])
  final List<Task> tasks;

  TaskTile(this.listName, this.tasks);
}
