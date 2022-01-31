import "package:flutter/material.dart";
import "package:todo_app/type_adapter/task.dart";

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text(title)), body: const TaskForm());
  }
}

class TaskForm extends StatefulWidget {
  const TaskForm({Key? key}) : super(key: key);

  @override
  _TaskFormState createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final _formKey = GlobalKey<FormState>();
  late String _inputTaskName;
  DateTime _inputDeadline = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter some text";
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Enter your task name"),
                  onChanged: (text) {
                    _inputTaskName = text;
                  },
                )),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Row(children: [
                  IconButton(
                      iconSize: 20,
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate:
                              DateTime.now().subtract(const Duration(days: 30)),
                          lastDate:
                              DateTime.now().add(const Duration(days: 720)),
                        );
                        if (date != null) {
                          setState(() {
                            _inputDeadline = date;
                          });
                        }
                      }),
                  Text(_inputDeadline.toString().split(" ")[0],
                      style: const TextStyle(fontSize: 20))
                ])),
            Center(
                child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  Task task = Task(_inputTaskName, _inputDeadline, false);
                  Navigator.pop(context, task);
                }
              },
              child: const Text("Submit"),
            ))
          ],
        ));
  }
}
