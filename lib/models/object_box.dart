import 'package:flutter/cupertino.dart';
import 'package:objectbox/objectbox.dart';
import 'package:tasks/main.dart';
import 'package:tasks/models/owner_model.dart';
import 'package:tasks/models/task_model.dart';
import 'package:tasks/objectbox.g.dart';

class ObjectBox {
  late final Store store;

  late final Box<TaskModel> taskBox;
  late final Box<OwnerModel> ownerBox;

  ObjectBox._create(this.store) {
    taskBox = Box<TaskModel>(store);
    ownerBox = Box<OwnerModel>(store);

    if (taskBox.isEmpty()) {
      putDemoData();
    }
  }

  void putDemoData() {
    OwnerModel owner1 = OwnerModel("Mehran");
    OwnerModel owner2 = OwnerModel("Nima");

    TaskModel task1 = TaskModel("Buying groceries.");
    TaskModel task2 = TaskModel("Washing dishes.");

    task1.owner.target = owner1;
    task2.owner.target = owner2;

    taskBox.putMany([task1, task2]);
  }

  static Future<ObjectBox> create() async {
    final store = await openStore();
    return ObjectBox._create(store);
  }

  Stream<List<TaskModel>> getTasks() {
    final builder = taskBox.query()
      ..order(TaskModel_.id, flags: Order.descending);
    return builder.watch(triggerImmediately: true).map(
          (query) => query.find(),
        );
  }

  void addTask(String taskText, OwnerModel owner) {
    TaskModel newTask = TaskModel(taskText);
    newTask.owner.target = owner;

    taskBox.put(newTask);
    debugPrint(
        "Added task: ${newTask.text} assigned to ${newTask.owner.target?.name}");
  }

  void updatetask(String taskText, OwnerModel owner, int taskId) {
    TaskModel? task = taskBox.get(taskId);
    task!.setText(taskText);
    task.owner.target = owner;
    taskBox.put(task);

    // TaskModel newTask = TaskModel(taskText);
    // newTask.owner.target = owner;
    //
    // taskBox.put(
    //   newTask,
    // );
  }
}
