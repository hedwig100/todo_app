import "package:flutter/material.dart";
import "package:todo_app/type_adapter/task.dart";
import "package:todo_app/type_adapter/task_tile.dart";
import "package:todo_app/type_adapter/data_time.dart";
import "package:todo_app/type_adapter/icon_data.dart";
import "package:todo_app/task_list.dart";
import 'package:hive/hive.dart';
import "package:hive_flutter/hive_flutter.dart";

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskTileAdapter());
  Hive.registerAdapter(DateTimeAdapter());
  Hive.registerAdapter(IconDataAdapter());
  var box = await Hive.openBox("mybox");
  runApp(MyApp(box: box));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.box}) : super(key: key);
  final Box box;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Todo App",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyTodoApp(title: "Todo App", box: box));
  }
}

class MyTodoApp extends StatefulWidget {
  const MyTodoApp({Key? key, required this.title, required this.box})
      : super(key: key);
  final String title;
  final Box box;

  @override
  _MyTodoAppState createState() => _MyTodoAppState();
}

class _MyTodoAppState extends State<MyTodoApp> {
  late List<TaskTile> _taskLists;
  // final List<TaskTile> _taskLists = [
  //   TaskTile(Icons.air, "Today's task", <Task>[
  //     Task("task1",DateTime(2020,9,7,0,0),true),
  //     Task("task2",DateTime(2021,3,30,0,0),false)
  //   ]),
  //   TaskTile(Icons.games,"Game to buy",<Task>[
  //     Task("task3",DateTime(2021,2,3,0,0),false),
  //     Task("task4",DateTime(2020,11,14,0,0),true)
  //   ])
  // ];

  @override
  void initState() {
    super.initState();
    print("initState");
    _taskLists = widget.box.get("todolist", defaultValue: []).cast<TaskTile>();
  }

  @override
  Future<void> dispose() async {
    await widget.box.close();
    print("diposed");
    super.dispose();
  }

  Future<void> _addTaskList(context) async {
    final _taskTile =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return TaskList(listName: "New Task List", tasks: []);
    }));

    if (!_taskTile.tasks.isEmpty) {
      setState(() {
        _taskLists.add(_taskTile);
        widget.box.put("todolist", _taskLists);
      });
    }
  }

  Future<void> _toTaskTile(context, index) async {
    final _taskTile = await Navigator.of(context).push(
        PageRouteBuilder(pageBuilder: (context, animation, secondaryAnimation) {
      return TaskList(
          listName: _taskLists[index].listName, tasks: _taskLists[index].tasks);
    }, transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final Animatable<Offset> tween = Tween(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0, 0),
      ).chain(CurveTween(curve: Curves.easeInOut));
      final Animation<Offset> offsetAnimation = animation.drive(tween);
      return SlideTransition(position: offsetAnimation, child: child);
    }));

    setState(() {
      _taskLists[index] = _taskTile;
      widget.box.put("todolist", _taskLists);
    });
  }

  Widget _itemBuilder(context, index) {
    return Dismissible(
        background: Container(
          color: Colors.red,
          child: const Icon(Icons.delete, color: Colors.white),
          alignment: const Alignment(1, 0),
          padding: const EdgeInsets.all(10),
        ),
        onDismissed: (DismissDirection direction) {
          setState(() {
            _taskLists.removeAt(index);
          });
        },
        key: ValueKey<TaskTile>(_taskLists[index]),
        child: ListTile(
            leading: Icon(_taskLists[index].icon),
            title: Text(_taskLists[index].listName),
            onTap: () => _toTaskTile(context, index)));
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
                    itemCount: _taskLists.length, itemBuilder: _itemBuilder)),
            InkWell(
                onTap: () => _addTaskList(context),
                child: Container(
                  child: Row(children: [
                    Container(
                        child: const Icon(Icons.add,
                            size: 25, color: Colors.white),
                        padding: const EdgeInsets.all(10.0)),
                    const Text("New List",
                        style: TextStyle(fontSize: 25, color: Colors.white))
                  ]),
                  margin: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(15)),
                ))
          ],
        ));
  }
}
