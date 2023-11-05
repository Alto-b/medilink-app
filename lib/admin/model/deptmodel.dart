
import 'package:hive/hive.dart';
part 'deptmodel.g.dart';

@HiveType(typeId: 1)
class DepartmentModel extends HiveObject{

  @HiveField(0)
   int? id;

  @HiveField(1)
  final String dept;

  DepartmentModel({required this.dept, this.id});
}
