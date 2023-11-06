
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medilink/admin/model/hospmodel.dart';

ValueNotifier<List<HospModel>> hospListNotifier=ValueNotifier([]);

//to add hospitals
Future<void> addHosp(HospModel value) async{
  final hospDB = await Hive.openBox<HospModel>('hosp_db');
  final _id = await hospDB.add(value);
  value.id=_id;
  hospListNotifier.value.add(value);
  hospListNotifier.notifyListeners();
  

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
  if(hospDB.isOpen){
    //print("hospital db is open before deletion");
    await hospDB.delete(id);
   
  getHosp();
  }
  else{
    //print("hospital db is not open before deletion");
  }
}

