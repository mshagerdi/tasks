import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks/components/task_add.dart';
import 'package:tasks/main.dart';
import 'package:tasks/models/menu_model.dart';

class PopMenuWidget extends StatelessWidget {
  PopMenuWidget({Key? key, required this.taskId}) : super(key: key);

  final int taskId;

  PopupMenuItem<MenuElement> buildItem(MenuElement item) =>
      PopupMenuItem<MenuElement>(
        child: Text(item.text),
        value: item,
      );

  void onSelected(BuildContext context, String selectedItem, int taskId) {
    if (selectedItem == "Delete") {
      objectBox.taskBox.remove(taskId);
      debugPrint("Task ${taskId} deleted.");
    }
    if (selectedItem == "Edit") {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AddTask(
            taskId: taskId,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuElement>(
      onSelected: (item) => onSelected(context, item.text, taskId),
      itemBuilder: (BuildContext context) =>
          [...Menuitems.items.map(buildItem).toList()],
      child: Icon(Icons.more_horiz),
    );
  }
}
