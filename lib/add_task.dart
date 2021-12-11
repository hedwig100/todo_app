import "package:flutter/material.dart"; 
import "package:todo_app/task.dart"; 

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({ Key? key ,required this.title}) : super(key: key);
  final String title; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(  
        title: Text(title)
      ), 
      body: const TaskForm() 
    ); 
  }
}

class TaskForm extends StatefulWidget {
  const TaskForm({ Key? key }) : super(key: key);

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>(); 
  late String _inputTaskName; 
  late String _inputDeadline; 

  @override
  Widget build(BuildContext context) {
    return Form(  
      key: _formKey, 
      child: Column(  
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(  
            padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 8), 
            child: TextFormField(  
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter some text"; 
                }
                return null; 
              },
              decoration: const InputDecoration( 
                border: UnderlineInputBorder(), 
                hintText: "Enter your task name"
              ),
              onChanged: (text) {
                _inputTaskName = text; 
              },
            )
          ),
          Padding(  
            padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 8), 
            child: TextFormField(  
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter some text"; 
                }
                return null; 
              },
              decoration: const InputDecoration( 
                border: UnderlineInputBorder(), 
                hintText: "Enter your task's deadline"
              ),
              onChanged: (text) {
                _inputDeadline = text; 
              },
            )
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Task task = Task(_inputTaskName,_inputDeadline); 
                  Navigator.pop(context,task); 
                }
              }, 
              child: const Text("Submit"), 
            )
          )
        ],
      )
    );
  }
}