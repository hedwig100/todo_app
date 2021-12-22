import "package:flutter/material.dart";
import "package:todo_app/task.dart";

class TaskDetail extends StatefulWidget {
  const TaskDetail({Key? key, required this.task,required this.listName}) : super(key: key);
  final Task task;
  final String listName; 

  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  final _formKey = GlobalKey<FormState>(); 

  void _backList(context) {
    Navigator.of(context).pop(widget.task); 
  }

  Widget _taskNameView() {
    return SizedBox(  
      height: 40,
      child: Row(
        children: [  
          Checkbox(  
            value: widget.task.isDone, 
            onChanged: (e)=>{setState((){widget.task.isDone = e!;})},
          ), 
          Flexible(child: Form(  
              key: _formKey, 
              child: TextFormField(  
                initialValue: widget.task.taskName,
                style: const TextStyle(fontSize: 30),
                decoration: null,
                onChanged: (text) {
                  setState((){widget.task.taskName = text;}); 
                },
              )
            )
          )
        ],
      ) 
    ); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(  
        leading: TextButton(  
          child: const Icon(Icons.arrow_back,color:Colors.white), 
          onPressed: ()=>_backList(context),
        ),
        title: Text(widget.listName)
      ),
      body: Column(
        children: [  
          _taskNameView(),
          Container()
        ],
      ),
    ); 
  }
}
