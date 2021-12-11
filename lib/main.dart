import "package:flutter/material.dart"; 
import "package:todo_app/add_task.dart"; 
import "package:todo_app/task.dart";

void main() {
  runApp(const MyApp()); 
}

class MyApp extends StatelessWidget {
  const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(  
      title: "Todo App", 
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyTodoApp(title: "Todo App")
    ); 
  }
}

class MyTodoApp extends StatefulWidget {
  const MyTodoApp({ Key? key ,required this.title}) : super(key: key);
  final String title; 

  @override
  _MyTodoAppState createState() => _MyTodoAppState();
}

class _MyTodoAppState extends State<MyTodoApp> {
  final _tasks = <Task>[]; 

  void _navigateAddTaskPage(BuildContext context) async {
    final task = await Navigator.push(
      context, 
      MaterialPageRoute(builder: (context) => AddTaskPage(title: widget.title))
    ); 
    setState((){_tasks.add(task);}); 
    Navigator.of(context).pop(); 
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("task is added")));  
  }

  void _delete(int index) {
    setState((){
      _tasks.removeAt(index); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(  
        title: Text(widget.title),
      ),
      drawer: Drawer(  
        child: ListView(
          children: <Widget>[
            DrawerHeader(  
              child: Text(widget.title,style: const TextStyle(fontSize: 30,color: Colors.white)), 
              decoration: const BoxDecoration(color: Colors.blue),
            ),
            TextButton(  
              child: const Text("Add Task",style: TextStyle(fontSize: 20)), 
              onPressed: () {
                _navigateAddTaskPage(context); 
              },
            )
          ]
        )
      ),
      // body: const Center(
      //   child: Text("WIP",style: TextStyle(fontSize: 80))
      // ), 
      body: ListView.builder(
        itemCount: _tasks.length, 
        itemBuilder: (context,index) {
          return TaskCard(
            task: _tasks[index], 
            callback: ()=>{_delete(index)},
          );
            // ListTile(
            //   title: Text(_tasks[index].deadline),
            //   subtitle: Text(_tasks[index].taskName), 
            //   onTap: () => {_delete(index)},
            // )
        },
      )
      ); 
  }
}