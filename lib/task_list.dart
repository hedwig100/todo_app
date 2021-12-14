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

  void _backHome(context) {
    Navigator.of(context).pop(TaskTile(  
      Icons.blur_on_outlined, 
      listName, 
      tasks
    )); 
  }

  void _addTask(context) async {
    final _task = await Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context,animation,secondaryAnimation) {
          return const AddTaskPage(title: "add task"); 
        }, 
        transitionsBuilder: (context,animation,secandaryAnimation,child) {
          final Animatable<Offset> tween = Tween(  
            begin: const Offset(1.0,0.0), 
            end: const Offset(0,0), 
          ).chain(CurveTween(curve: Curves.easeInOut)); 
          final Animation<Offset> offsetAnimation = animation.drive(tween); 
          return SlideTransition(
            position: offsetAnimation,
            child: child
          ); 
        }
      )
    ); 
    setState(() {
      tasks.add(_task); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar( 
            leading: TextButton(  
              child: const Icon(Icons.arrow_back,color: Colors.white),
              onPressed: () => _backHome(context),
            ),
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
                onTap: ()=>_addTask(context), 
                child: Row(
                  children: const [Icon(Icons.add), Text("New Task")],
                ))
          ],
        ));
  }
}
