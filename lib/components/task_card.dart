import 'package:flutter/material.dart';
import 'package:tasks/main.dart';
import 'package:tasks/models/owner_model.dart';
import 'package:tasks/models/task_model.dart';
import 'package:tasks/widgets/pop_menu_widget.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({super.key, required this.task});

  final TaskModel task;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  List<OwnerModel> owners = objectBox.ownerBox.getAll();
  OwnerModel? currentOwner;
  bool? taskStatus;

  void toggleCheckbox() {
    bool newStatus = widget.task.setFinished();
    objectBox.taskBox.put(widget.task);

    setState(() {
      taskStatus = newStatus;
    });
  }

  @override
  void initState() {
    currentOwner = widget.task.owner.target;

    taskStatus = widget.task.isFinished;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          widget.task.text,
          style: TextStyle(
              // fontSize: 22,
              fontWeight: FontWeight.bold,
              decoration: taskStatus! ? TextDecoration.lineThrough : null),
        ),
        subtitle: Text("Assign to ${currentOwner?.name}"),
        leading: Checkbox(
          value: taskStatus,
          shape: CircleBorder(),
          onChanged: (bool? value) {
            toggleCheckbox();
          },
        ),
        trailing: PopMenuWidget(taskId: widget.task.id),
      ),
    );
  }
}
