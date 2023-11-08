

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medilink/guest/model/usermodel.dart';

ValueNotifier<List<UserModel>> userListNotifier=ValueNotifier([]);

//to add departments
Future<void> addUser(UserModel value) async{
  final userDB = await Hive.openBox<UserModel>('user_db');
  final _id=await userDB.add(value);
  value.id=_id;
  userListNotifier.value.add(value);
  userListNotifier.notifyListeners();
}

//to get user info
// Future<void> getUser()async{
//   final userDB = await Hive.openBox<UserModel>('user_db');
//   userListNotifier.value.clear();
//   userListNotifier.value.addAll(userDB.values);
//   userListNotifier.notifyListeners();

// }
