class Task extends Object {
  final String taskName;
  final String deadline;
  bool isDone;

  Task(this.taskName, this.deadline, this.isDone);
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