

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medilink/admin/model/doctor_model.dart';

ValueNotifier<List<DoctorModel>> doctorListNotifier=ValueNotifier([]);

//to add doctors
Future<void> addDoctor(DoctorModel value) async{
  final doctorDB = await Hive.openBox<DoctorModel>('doctor_db');
  final id=await doctorDB.add(value);
  final data = doctorDB.get(id);
  await doctorDB.put(id,DoctorModel(name: data!.name, gender: data!.gender, qualification:data!.qualification, dob: data!.dob, doj: data!.doj, hospital:data!.hospital, specialization: data!.specialization,photo: data!.photo,id: id) );
  print(doctorDB.values);
}

//to get doctors
Future<void> getDoctor() async {
  final doctorDB = await Hive.openBox<DoctorModel>('doctor_db');
  doctorListNotifier.value.clear();
  doctorListNotifier.value.addAll(doctorDB.values);

  // Sort the list of doctors in ascending order of names
  doctorListNotifier.value.sort((a, b) => a.name.compareTo(b.name));

  doctorListNotifier.notifyListeners();
}