import 'package:objectbox/objectbox.dart';
import 'package:tasks/models/owner_model.dart';

@Entity()
class TaskModel {
  @Id()
  int id;

  String text;
  bool isFinished;

  @Property(type: PropertyType.date) // Store as int in milliseconds
  DateTime? dateTime;

  TaskModel(this.text,
      {this.id = 0, this.isFinished = false, DateTime? dateTime})
      : dateTime = dateTime ?? DateTime.now();

  final owner = ToOne<OwnerModel>();

  bool setFinished() {
    isFinished = !isFinished;
    return isFinished;
  }

  String setText(String newText) {
    text = newText;
    return newText;
  }
}
