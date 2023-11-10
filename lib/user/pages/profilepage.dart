// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medilink/guest/db/user_functions.dart';
import 'package:medilink/guest/model/usermodel.dart';
import 'package:medilink/guest/pages/login.dart';
import 'package:medilink/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

    String userEmail = ''; // State variable to store the user's email
  UserModel? currentUser;

   @override
  void initState() {
    super.initState();
    // Call the getUser function when the page is initialized
    getUser();
  }

  Future<void> getUser() async {
    // Retrieve currentUser email from shared preferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    userEmail = prefs.getString('currentUser') ?? '';

    // Find the user in Hive using the email
    final userBox = await Hive.openBox<UserModel>('user_db');
    currentUser = userBox.values.firstWhere(
      (user) => user.email == userEmail,
      //orElse: () => null,
    );

    setState(() {}); // Update the UI with the fetched data
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(
        title: Text("profile page"),
        actions: [
          IconButton(onPressed: (){
            logOut(context);
          }, icon: Icon(Icons.logout))
        ],
      ),

      //body
      // body: Column(
      //   children: [
      //     Text("email: ")
      //   ],
      // ),

    body: currentUser!=null ?
    Column(
      children: [
        Text("email :${currentUser!.email}"),
        Text("name :${currentUser!.fullname}"),
        Text("dob :${currentUser!.dob}")

      ],
    )
    :Center(
      child: Column(
        children: [
          Text("user not logged in")
        ],
      ),
    )

    );
  }

//log out
void logOut(BuildContext context){
      showDialog(context: context, builder: (context){
        return AlertDialog(
          title:Text("Logout"),
          content: Text("Do you want to leave ?"),
          actions: [
            ElevatedButton(onPressed: (){
              signout(context);
            }, child: Text("Yes")),
            ElevatedButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("No")),
          ],
        );
      });
    }
//signout
  signout(BuildContext ctx) async{

    final _sharedPrefs= await SharedPreferences.getInstance();
  await _sharedPrefs.clear();

    // ignore: use_build_context_synchronously
    Navigator.of(ctx).pushAndRemoveUntil(MaterialPageRoute(builder: (ctx)=>LoginPage()), (route) => false);
    _sharedPrefs.setBool(SAVE_KEY_NAME, false);
  }



}