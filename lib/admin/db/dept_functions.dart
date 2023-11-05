

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medilink/admin/model/deptmodel.dart';



ValueNotifier<List<DepartmentModel>> deptListNotifier=ValueNotifier([]);

//to add departments
Future<void> addDepartment(DepartmentModel value) async{
  final deptBox = await Hive.openBox<DepartmentModel>('dept_box');
  final id=await deptBox.add(value);
  value.id=id;

  deptListNotifier.value.add(value);
  deptListNotifier.notifyListeners();
}

//to get departments
Future<void> getDepartment() async{
  final deptDB = await Hive.openBox<DepartmentModel>('dept_db');
  deptListNotifier.value.clear();

  deptListNotifier.value.addAll(deptDB.values);
  deptListNotifier.notifyListeners();
}

//to delete departments
Future<void> deleteDept(int id) async{
  final deptDB = await Hive.openBox<DepartmentModel>('dept_db');
  await deptDB.delete(id);
  getDepartment();
  deptListNotifier.notifyListeners();
}