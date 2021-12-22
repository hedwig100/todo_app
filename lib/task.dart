import "package:flutter/material.dart"; 

class Task extends Object {
  String taskName;
  DateTime deadline;
  bool isDone;
  String memo = "";  

  Task(this.taskName, this.deadline, this.isDone);
}

class TaskTile extends Object {
  final IconData icon;
  final String listName;
  final List<Task> tasks;

  TaskTile(this.icon, this.listName, this.tasks);
}

// class TaskCard extends StatelessWidget {
//   const TaskCard({ Key? key,required this.task,required this.callback}) : super(key: key);
//   final Task task; 
//   final callback; 

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Row(
//         children: <Widget>[
//           Text(task.taskName,style: const TextStyle(fontSize: 20)),
//           Text(task.deadline,style: const TextStyle(fontSize: 20)),
//           FloatingActionButton(  
//             onPressed: callback,
//             mini: true, 
//             child: const Icon(Icons.remove_circle_outline),
//           )
//         ], 
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       ),
//     );
//   }
// }