// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medilink/admin/model/deptmodel.dart';
import 'package:medilink/admin/model/hospmodel.dart';
import 'package:medilink/guest/model/usermodel.dart';
import 'package:medilink/guest/pages/splash.dart';


const SAVE_KEY_NAME ="UserLoggedIn";
void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

   Hive.openBox<DepartmentModel>('dept_db');
   Hive.openBox<HospModel>('hosp_db');
   Hive.openBox<UserModel>('user_db');
  
  if(!Hive.isAdapterRegistered(DepartmentModelAdapter().typeId)){
      Hive.registerAdapter(DepartmentModelAdapter());
  }
  if(!Hive.isAdapterRegistered(HospModelAdapter().typeId)){
      Hive.registerAdapter(HospModelAdapter());
  }
  if(!Hive.isAdapterRegistered(UserModelAdapter().typeId)){
    Hive.registerAdapter(UserModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medilink',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            //color: Colors.white,
          )
        ),
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Splash()
    );
  }
}
