import "package:flutter/material.dart";
import "package:todo_app/task.dart";
import "package:todo_app/task_list.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Todo App",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyTodoApp(title: "Todo App"));
  }
}

class MyTodoApp extends StatefulWidget {
  const MyTodoApp({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyTodoAppState createState() => _MyTodoAppState();
}

class _MyTodoAppState extends State<MyTodoApp> {
  final List<TaskTile> _taskLists = [
    TaskTile(Icons.air, "Today's task", <Task>[
      Task("task1","1/23",true), 
      Task("task2","2/4",false)
    ]), 
    TaskTile(Icons.games,"Game to buy",<Task>[
      Task("task3","4/3",false), 
      Task("task4","12/12",true)
    ])
  ];

  void _addTaskList(context) async {
    final _taskTile = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const TaskList(
          listName: "New Task List", 
          tasks: <Task>[]
      );
    }));

    setState((){
      _taskLists.add(_taskTile); 
    }); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.task),
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Flexible(
                child: ListView.builder(
                    itemCount: _taskLists.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Icon(_taskLists[index].icon),
                        title: Text(_taskLists[index].listName),
                        onTap: () {
                          Navigator.of(context).push(
                          PageRouteBuilder(
                            pageBuilder: (context,animation,secondaryAnimation) {
                              return TaskList(  
                                listName: _taskLists[index].listName, 
                                tasks: _taskLists[index].tasks
                              ); 
                            },
                            transitionsBuilder: (context,animation,secondaryAnimation,child) {
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
                        },
                      );
                    })),
            InkWell(
                // onTap: () {
                //   Navigator.push(context, MaterialPageRoute(builder: (context) {
                //     return const TaskList(
                //         listName: "New Task List", tasks: <Task>[]);
                //   }));
                // },
                onTap: () => _addTaskList(context), 
                child: Row(
                  children: const [Icon(Icons.add), Text("New List")],
                ))
          ],
        ));
  }
}

class TaskTile extends Object {
  final IconData icon;
  final String listName;
  final List<Task> tasks;

  TaskTile(this.icon, this.listName, this.tasks);
}
