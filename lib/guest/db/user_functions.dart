

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medilink/guest/model/usermodel.dart';

ValueNotifier<List<UserModel>> userListNotifier=ValueNotifier([]);

//to add departments
Future<void> addUser(UserModel value) async{
  final deptBox = await Hive.openBox<UserModel>('user_db');
  final _id=await deptBox.add(value);
  value.id=_id;
  userListNotifier.value.add(value);
  userListNotifier.notifyListeners();
}