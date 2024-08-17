import 'package:objectbox/objectbox.dart';

@Entity()
class OwnerModel {
  @Id()
  int id;

  String name;

  OwnerModel(this.name, {this.id = 0});
}
