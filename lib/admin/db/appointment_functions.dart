
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medilink/admin/model/appointment_model.dart';

ValueNotifier<List<AppointmentModel>> appointmentListNotifier=ValueNotifier([]);

//to add appointment
Future<void> addAppointment(AppointmentModel value) async{
  final appointmentDB = await Hive.openBox<AppointmentModel>('appointment_db');
  final id=await appointmentDB.add(value);
  final data = appointmentDB.get(id);
  await appointmentDB.put(id,AppointmentModel(name: data!.name, gender: data.gender, dob: data.dob, marital: data.marital, email: data.email, mobile: data.mobile, address: data.address,title: data.title,date: data.date,id: id));
  getAppointment();
}

//to get appointments
Future<void> getAppointment() async{
  final appointmentDB = await Hive.openBox<AppointmentModel>('appointment_db');
  appointmentListNotifier.value.clear();
  appointmentListNotifier.value.addAll(appointmentDB.values);
  appointmentListNotifier.notifyListeners();
}

//to get appointment count
Future<int> appointmentStats() async{
  final appointmentDB = await Hive.openBox<AppointmentModel>('appointment_db');
  final appointmentCount=appointmentDB.length;
  return appointmentCount;
}