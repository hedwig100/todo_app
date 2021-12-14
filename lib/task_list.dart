import "package:flutter/material.dart";
import "package:todo_app/add_task.dart";
import "package:todo_app/task.dart";

class TaskList extends StatefulWidget {
  const TaskList({Key? key, required this.tasks, required this.listName})
      : super(key: key);
  final List<Task> tasks;
  final String listName;

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  late List<Task> tasks;
  late String listName;

  @override
  void initState() {
    tasks = widget.tasks;
    listName = widget.listName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar( 
            title: const Text("Home")
        ),
        body: Column(
          children: [
            Text(listName, style: const TextStyle(fontSize: 30)),
            Flexible(
                child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Checkbox(  
                    value: tasks[index].isDone,
                    onChanged: (e) => {setState((){tasks[index].isDone = e!;})},
                  ),
                  title: Text(tasks[index].taskName),
                  trailing: const Icon(Icons.star),
                );
              },
            )),
            InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const AddTaskPage(title: "a");
                  }));
                },
                child: Row(
                  children: const [Icon(Icons.add), Text("New Task")],
                ))
          ],
        ));
  }
}
