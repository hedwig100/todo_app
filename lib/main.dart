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
      Task("task1",DateTime(2020,9,7,0,0),true), 
      Task("task2",DateTime(2021,3,30,0,0),false)
    ]), 
    TaskTile(Icons.games,"Game to buy",<Task>[
      Task("task3",DateTime(2021,2,3,0,0),false), 
      Task("task4",DateTime(2020,11,14,0,0),true)
    ])
  ];

  void _addTaskList(context) async {
    final _taskTile = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TaskList(
          listName: "New Task List", 
          tasks: []
      ); 
    }));

    if (!_taskTile.tasks.isEmpty) {
      setState((){
        _taskLists.add(_taskTile); 
      }); 
    }
  }

  void _toTaskTile(context,index) async {
    final _taskTile = await Navigator.of(context).push(
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

    setState((){
      _taskLists[index] = _taskTile; 
    }); 
  }

  Widget _itemBuilder(context,index) {
    return Dismissible(  
      background: Container(  
        color: Colors.red,
        child: const Icon(Icons.delete,color: Colors.white), 
        alignment: const Alignment(1, 0),
        padding: const EdgeInsets.all(10),
      ),
      onDismissed: (DismissDirection direction) {
        setState((){
          _taskLists.removeAt(index); 
        }); 
      },
      key: ValueKey<TaskTile>(_taskLists[index]),
      child: ListTile(
        leading: Icon(_taskLists[index].icon),
        title: Text(_taskLists[index].listName),
        onTap: () => _toTaskTile(context, index)
      )
    );
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
                itemBuilder: _itemBuilder
              )
            ),
            InkWell(
              onTap: () => _addTaskList(context), 
              child: Container(  
                child: Row(children: [
                  Container(child: const Icon(Icons.add,size: 25,color: Colors.white),padding: const EdgeInsets.all(10.0)), 
                  const Text("New List",style: TextStyle(fontSize: 25,color: Colors.white))
                ]), 
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.blue, 
                  borderRadius: BorderRadius.circular(15)
                ),
              )
            )
          ],
        ));
  }
}