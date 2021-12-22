import "package:flutter/material.dart";
import "package:todo_app/task.dart";

class TaskDetail extends StatefulWidget {
  const TaskDetail({Key? key, required this.task, required this.listName})
      : super(key: key);
  final Task task;
  final String listName;

  @override
  _TaskDetailState createState() => _TaskDetailState();
}

class _TaskDetailState extends State<TaskDetail> {
  final _taskFormKey = GlobalKey<FormState>();
  final _memoFormKey = GlobalKey<FormState>();
  void _backList(context) {
    Navigator.of(context).pop(widget.task);
  }

  Widget _taskNameView() {
    return SizedBox(
        height: 100,
        child: Row(
          children: [
            Container(
              child: Checkbox(
                value: widget.task.isDone,
                onChanged: (e) => {
                  setState(() {
                    widget.task.isDone = e!;
                  })
              }),
              margin: const EdgeInsets.all(10.0)
            ),
            Flexible(
                child: Form(
                    key: _taskFormKey,
                    child: TextFormField(
                      initialValue: widget.task.taskName,
                      style: const TextStyle(fontSize: 30),
                      decoration: null,
                      onChanged: (text) {
                        setState(() {
                          widget.task.taskName = text;
                        });
                      },
                    )))
          ],
        ));
  }

  Widget _memoView() {
    return Column(
      children: [
        const Text("MEMO: ", style: TextStyle(fontSize: 25)),
        SizedBox(
            height: 200,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: Form(
                    key: _memoFormKey,
                    child: TextFormField(
                      initialValue: widget.task.memo,
                      style: const TextStyle(fontSize: 25),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'write a memo about this task',
                      ),
                      onChanged: (text) {
                        setState(() {
                          widget.task.memo = text;
                        });
                      },
                      keyboardType: TextInputType.multiline,
                      minLines: 4,
                      maxLines: 4,
                    ))))
      ],
    );
  }

  Widget _dateView() {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(children: [
          IconButton(
              iconSize: 25,
              icon: const Icon(Icons.calendar_today),
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 30)),
                  lastDate: DateTime.now().add(const Duration(days: 720)),
                );
                if (date != null) {
                  setState(() {
                    widget.task.deadline = date;
                  });
                }
              }),
          Text(widget.task.deadline.toString().split(" ")[0],
              style: const TextStyle(fontSize: 25))
        ]));
  }

  Widget _importantView() {
    return Padding(  
      padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 4),
      child: Row(children: [  
        IconButton(  
          iconSize: 25,
          color: widget.task.isImportant ? Colors.yellow : Colors.grey,
          icon: const Icon(Icons.star), 
          onPressed: () {
            setState((){widget.task.isImportant = !widget.task.isImportant;});
          },
        ),
        const Text("Important task",style: TextStyle(fontSize: 25))
      ],)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: TextButton(
            child: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => _backList(context),
          ),
          title: Text(widget.listName)),
      body: Column(
        children: [
          _taskNameView(),
          _dateView(),
          _importantView(),
          _memoView()
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
