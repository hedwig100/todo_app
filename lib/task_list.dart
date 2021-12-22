import "package:flutter/material.dart";
import "package:todo_app/add_task.dart";
import "package:todo_app/task.dart";
import "package:todo_app/task_detail.dart";

class TaskList extends StatefulWidget {
  const TaskList({Key? key,required this.tasks,required this.listName})
      : super(key: key);
  final List<Task> tasks;
  final String listName;

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> { 
  late List<Task> _tasks;
  late String _listName;
  final _formKey = GlobalKey<FormState>(); 

  @override
  void initState() {
    super.initState();
    _tasks = widget.tasks; 
    _listName = widget.listName;
  }

  void _backHome(context) {
    Navigator.of(context).pop(TaskTile(  
      Icons.blur_on_outlined, 
      _listName, 
      _tasks
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
            begin: const Offset(0.0,1.0), 
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
      _tasks.add(_task); 
    });
  }

  void _toTaskDetail(context,index) async {
    final task = await Navigator.of(context).push(  
      PageRouteBuilder(
        pageBuilder: (context,animation,secondaryAnimation) {
          return TaskDetail(task: _tasks[index],listName: widget.listName); 
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

    setState((){
      _tasks[index] = task; 
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
          _tasks.removeAt(index); 
        }); 
      },
      key: ValueKey<Task>(_tasks[index]),
      child: ListTile(
        leading: Checkbox(  
          value: _tasks[index].isDone,
          onChanged: (e) => {setState((){_tasks[index].isDone = e!;})},
        ),
        onTap: ()=>_toTaskDetail(context, index),
        title: Text(_tasks[index].taskName),
        trailing: IconButton(
          color: _tasks[index].isImportant ? Colors.yellow : Colors.grey,
          icon: const Icon(Icons.star), 
          onPressed: () {
            setState((){_tasks[index].isImportant = !_tasks[index].isImportant;});
          },
        ),
      )
    );
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
            Form(  
              key: _formKey, 
              child: TextFormField(
                initialValue: _listName,
                style: const TextStyle(fontSize: 30),
                decoration: null,
                onChanged: (text) {
                  setState((){_listName = text;}); 
                },
              )
            ),
            // Text(_listName, style: const TextStyle(fontSize: 30)),
            Flexible(
                child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: _itemBuilder,
            )),
            InkWell(
              onTap: ()=>_addTask(context),
              child: Container(  
                child: Row(children: [
                  Container(child: const Icon(Icons.add,size: 25,color: Colors.white),padding: const EdgeInsets.all(10.0)), 
                  const Text("New Task",style: TextStyle(fontSize: 25,color: Colors.white))
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
