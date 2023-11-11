// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables



import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
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

    String userEmail = ''; 
  UserModel? currentUser;
  
   int age=0;

   

   @override
  void initState() {
    super.initState();
    // Call the getUser function when the page is initialized
    getUser();    
  }

  Future<void> getUser() async {
    // Retrieve currentUser email from shared preferences
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   
   //if(currentUser != null)
    userEmail = prefs.getString('currentUser') ?? '';
    // check the user in Hive using the email
    final userBox = await Hive.openBox<UserModel>('user_db');
    currentUser = userBox.values.firstWhere(
      (user) => user.email == userEmail,
      //orElse: () => null,
    );
    calculateAge();
    setState(() {}); 
  }
void calculateAge() {
    if (currentUser != null) {
      String dobString = currentUser!.dob ?? '';
      DateTime dob = DateTime.parse(dobString);
      DateTime currentDate = DateTime.now();
      Duration difference = currentDate.difference(dob);
      age = (difference.inDays / 365).floor();
    }
  }


  @override
  Widget build(BuildContext context) {

//calculate age
// String dobString = currentUser?.dob??''; // Assuming currentUser.dob is a string

// DateTime dob = DateTime.parse(dobString);

// DateTime currentDate = DateTime.now();
// Duration difference = currentDate.difference(dob);
// age = (difference.inDays / 365).floor();

//print('User\'s age is $age years');}
//age calculated

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
    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Align(
        child: Column(
          children: [
            // Text("email :${currentUser!.email}"),
            // Text("name :${currentUser!.fullname}"),
            // Text("dob :${currentUser!.dob}")
          SizedBox(height: 30,),
          Container(
            decoration: BoxDecoration(
              //color: Colors.grey,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 2)
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  //name
                  Text(
                    "Name : ${currentUser!.fullname}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    
                    ),
                  ),SizedBox(height: 10,),
                  //email
                  Text(
                    "Email : ${currentUser!.email}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    
                    ),
                  ),SizedBox(height: 10,),
                  //Gender
                  Text(
                    "Gender : ${currentUser!.gender}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    
                    ),
                  ),SizedBox(height: 10,),
                  //Date of birth
                  Text(
                    "Date  Of Birth : ${currentUser!.dob}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    
                    ),
                  ),SizedBox(height: 10,),
                  //Date of birth
                  Text(
                    "Age: $age Years",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    
                    ),
                  ),SizedBox(height: 10,),
                ],
              ),
            ),
          )
           
          
          ],
        ),
      ),
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