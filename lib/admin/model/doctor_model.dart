
import 'package:hive_flutter/hive_flutter.dart';
part 'doctor_model.g.dart';

@HiveType(typeId: 6)
class DoctorModel{

  @HiveField(0)
  int? id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String gender;

  @HiveField(3)
  final String qualification;

  @HiveField(4)
  final String dob;

  @HiveField(5)
  final String doj;

  @HiveField(6)
  final String hospital;

  @HiveField(7)
  final String specialization;

  DoctorModel({required this.name,required this.gender,required this.qualification,required this.dob,required this.doj,required this.hospital,required this.specialization,this.id});


}