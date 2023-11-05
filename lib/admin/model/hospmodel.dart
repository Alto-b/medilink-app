
import 'package:hive/hive.dart';
part 'hospmodel.g.dart';

@HiveType(typeId: 0)
class HospModel extends HiveObject{

  @HiveField(0)  
    int? id;

  @HiveField(1)
  final String hosp;

  HospModel({required this.hosp,this.id});
} 