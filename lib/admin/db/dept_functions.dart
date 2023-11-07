

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medilink/admin/model/deptmodel.dart';



ValueNotifier<List<DepartmentModel>> deptListNotifier=ValueNotifier([]);

//to add departments
Future<void> addDepartment(DepartmentModel value) async{
  final deptBox = await Hive.openBox<DepartmentModel>('dept_db');
  final id=await deptBox.add(value);
  final data = deptBox.get(id);
  await deptBox.put(id,DepartmentModel(dept: data!.dept,id: id) );
  getDepartment();
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
}

//to search departments
Future<List<DepartmentModel>> searchDepartments(String keyword) async {
  final deptDB = await Hive.openBox<DepartmentModel>('dept_db');
  final departments = await deptDB.values.toList();

  // Use the `where` method to filter the data based on the search criteria
  final filteredDepartments = departments.where((department) {
    // Modify the condition based on your search criteria
    return department.dept.contains(keyword);
  }).toList();

  return filteredDepartments;
}