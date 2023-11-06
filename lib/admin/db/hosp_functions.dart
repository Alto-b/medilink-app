
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medilink/admin/model/hospmodel.dart';

ValueNotifier<List<HospModel>> hospListNotifier=ValueNotifier([]);

//to add hospitals
Future<void> addHosp(HospModel value) async{
  final hospDB = await Hive.openBox<HospModel>('hosp_db');
  final id=await hospDB.add(value);
  final data = hospDB.get(id);
  await hospDB.put(id,HospModel(hosp: data!.hosp,id: id) );
  getHosp();

}

//to get hospitals
Future<void> getHosp() async{
  final hospDB = await Hive.openBox<HospModel>('hosp_db');
  hospListNotifier.value.clear();
  hospListNotifier.value.addAll(hospDB.values);
  hospListNotifier.notifyListeners();
 
}

//to delete hospitals
Future<void> deleteHosp(int id)async{
  final hospDB = await Hive.openBox<HospModel>('hosp_db');
   hospDB.delete(id);
    getHosp();

}

