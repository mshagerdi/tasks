import 'package:flutter/cupertino.dart';
import 'package:tasks/components/task_card.dart';
import 'package:tasks/main.dart';
import 'package:tasks/models/task_model.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  TaskCard Function(BuildContext, int) _itemBuilder(List<TaskModel> tasks) {
    return (BuildContext context, int index) => TaskCard(task: tasks[index]);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      key: UniqueKey(),
      stream: objectBox.getTasks(),
      builder: (context, snapshot) {
        if (snapshot.data?.isNotEmpty ?? false) {
          return ListView.builder(
              itemCount: snapshot.hasData ? snapshot.data!.length : 0,
              itemBuilder: _itemBuilder(snapshot.data ?? []));
        } else {
          return Center(
            child: Text("Press the + icon to add tasks."),
          );
        }
      },
    );
  }
}
