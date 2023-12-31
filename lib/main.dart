// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medilink/admin/model/appointment_model.dart';
import 'package:medilink/admin/model/deptmodel.dart';
import 'package:medilink/admin/model/doctor_model.dart';
import 'package:medilink/admin/model/feedback_model.dart';
import 'package:medilink/admin/model/hospmodel.dart';
import 'package:medilink/admin/model/telemedicine_model.dart';
import 'package:medilink/guest/model/usermodel.dart';
import 'package:medilink/guest/pages/splash.dart';
import 'package:medilink/styles/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:medilink/user/pages/settings.dart';


const SAVE_KEY_NAME ="UserLoggedIn";
void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

   Hive.openBox<DepartmentModel>('dept_db');
   Hive.openBox<HospModel>('hosp_db');
   Hive.openBox<UserModel>('user_db');
   Hive.openBox<FeedBackModel>('feedback_db');
   Hive.openBox<TelemedicineModel>('telemedicine_db');
   Hive.openBox<AppointmentModel>('appointment_db');
   Hive.openBox<DoctorModel>('doctor_db');
  
  if(!Hive.isAdapterRegistered(DepartmentModelAdapter().typeId)){
      Hive.registerAdapter(DepartmentModelAdapter());
  }
  if(!Hive.isAdapterRegistered(HospModelAdapter().typeId)){
      Hive.registerAdapter(HospModelAdapter());
  }
  if(!Hive.isAdapterRegistered(UserModelAdapter().typeId)){
    Hive.registerAdapter(UserModelAdapter());
  }
  if(!Hive.isAdapterRegistered(FeedBackModelAdapter().typeId)){
    Hive.registerAdapter(FeedBackModelAdapter());
  }
  if(!Hive.isAdapterRegistered(TelemedicineModelAdapter().typeId)){
    Hive.registerAdapter(TelemedicineModelAdapter());
  }
  if(!Hive.isAdapterRegistered(AppointmentModelAdapter().typeId)){
    Hive.registerAdapter(AppointmentModelAdapter());
  }
  if(!Hive.isAdapterRegistered(DoctorModelAdapter().typeId)){
    Hive.registerAdapter(DoctorModelAdapter());
  }
 
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Medilink',
      debugShowCheckedModeBanner: false,
      
      //theme: oldTheme(),
       home: Splash(),
      // themeMode: ThemeMode.system, 
      // theme: MyThemes.lightTheme,
      // darkTheme: MyThemes.darkTheme,
      theme: oldTheme(),


    );
  }

  ThemeData newThemedata() {
    return ThemeData(
       brightness: Brightness.dark
    );
  }

  ThemeData oldTheme() {
    return ThemeData(
      appBarTheme: AppBarTheme(
        centerTitle: true,
      ),
      //colorScheme: ColorScheme.fromSeed(seedColor: Color(0x001abc8d)),
      // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.lightGreen,cardColor: const Color.fromARGB(255, 255, 255, 255)),
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple,
                                            error: Colors.red[400],
                                        ),
      useMaterial3: true,
     );
  }

}
