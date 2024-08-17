import 'package:flutter/material.dart';
import 'package:tasks/constants/constants.dart';
import 'package:tasks/main.dart';
import 'package:tasks/models/owner_model.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key, required this.taskId});

  final int taskId;

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final inputController = TextEditingController();
  final ownerInputController = TextEditingController();
  List<OwnerModel> owners = objectBox.ownerBox.getAll();
  late OwnerModel currentOwner;

  @override
  void initState() {
    currentOwner = (widget.taskId == -1) ||
            objectBox.taskBox.get(widget.taskId)!.owner.target == null
        ? owners[0]
        : objectBox.taskBox.get(widget.taskId)!.owner.target!;
    inputController.text =
        (widget.taskId == -1) ? "" : objectBox.taskBox.get(widget.taskId)!.text;
    super.initState();
  }

  void updateOwner(int newOwnerId) {
    final OwnerModel newCurrentOwner = objectBox.ownerBox.get(newOwnerId)!;
    setState(() {
      currentOwner = newCurrentOwner;
    });
  }

  void createOwner() {
    OwnerModel newOwner = OwnerModel(ownerInputController.text);
    objectBox.ownerBox.put(newOwner);
    List<OwnerModel> newOwnerList = objectBox.ownerBox.getAll();
    print(newOwner.id);

    setState(() {
      currentOwner = newOwner;
      owners = newOwnerList;
    });
  }

  void createTask() {
    if (inputController.text.isNotEmpty) {
      objectBox.addTask(inputController.text, currentOwner);
    }
  }

  void updateTask() {
    if (inputController.text.isNotEmpty) {
      objectBox.updatetask(inputController.text, currentOwner, widget.taskId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add task"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          children: [
            TextField(
              controller: inputController,
            ),
            Row(
              children: [
                Text(
                  "Asseig to: ",
                  style: TextStyle(fontSize: 19),
                ),
                DropdownButton<int>(
                  value: currentOwner.id,
                  items: owners
                      .map(
                        (element) => DropdownMenuItem(
                          value: element.id,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // objectBox.taskBox
                              //             .get(widget.taskId)!
                              //             .owner
                              //             .target ==
                              //         null
                              //     ? Text('No one')
                              //     :
                              Text(element.name),
                              IconButton(
                                onPressed: () {
                                  objectBox.ownerBox.remove(element.id);
                                  print('Owner ${element.id} deleted.');
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => updateOwner(value!),
                ),
                const Spacer(),
                TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("New Owner"),
                        content: TextField(
                          controller: ownerInputController,
                          decoration: InputDecoration(
                            hintText: "Enter the owner name",
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              createOwner();
                              Navigator.of(context).pop();
                            },
                            child: Text("Submit"),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text(
                    "Add Owner",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    (widget.taskId == -1) ? createTask() : updateTask();
                    // Navigator.of(context).pop();

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyHomePage(
                          title: (homePageTitle),
                        ),
                      ),
                    );
                  },
                  child: Text("Save"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
