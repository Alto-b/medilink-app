// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medilink/guest/model/usermodel.dart';
import 'package:medilink/guest/pages/signup.dart';
import 'package:medilink/user/mainpage.dart';
import 'package:medilink/user/pages/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

    final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
         // title: Text("login"),
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                Form(
                  key:_formKey ,
                  child: Column(
                  children: [
                    SizedBox(height: 50,),
                    Image.network('https://i.ibb.co/YZWjL9Y/Screenshot-2023-10-22-204311-removebg-preview.png',
                  width: 200,),
              SizedBox(height: 50,),
                    
                    //email textfield
                    TextFormField(
                      controller: _emailController,
                      validator: validateEmail,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30)
                        ),
                        hintText: "email id "
                      ),
                    ),
                    SizedBox(height: 30,),
        
                    //password textfield
                    TextFormField(
                      controller: _passwordController,
                      validator: validatepassword,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        hintText: "password "
                      ),
                    ),
                    SizedBox(height: 30,),
        
                    //login button
                    ElevatedButton(onPressed: (){
                      submit();
                    }, child: Text("Login")),
                    SizedBox(height: 10,),
        
        
                    //signup button
                    TextButton(onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpPage(),));
                    }, child: Text("signup"))
                  ],
                ))
              ],
            ),
          ),
        ),
     
    );
  }

  //to validate email
String? validateEmail(String? value) {
  
  final trimmedValue = value?.trim();

  if (trimmedValue == null || trimmedValue.isEmpty) {
    return 'Email is required';
  }

  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
  );

  if (!emailRegExp.hasMatch(trimmedValue)) {
    return 'Invalid email address';
  }

  return null; 
}

//to validate password
String? validatepassword(String? value){
  final trimmedValue = value?.trim();

  if(trimmedValue == null || trimmedValue.isEmpty){
    return 'Cannot be empty';
  }
  return null;
}

//submit form
void submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      login(_emailController.text, _passwordController.text, context);
      
    }
  }

//to login
void login(String email,String password,BuildContext context) async{

final userDB=await Hive.openBox<UserModel>('user_db');

UserModel? user;
for(var i=0;i<userDB.length;i++){
  final currentUser = userDB.getAt(i);

  if(currentUser?.email == email && currentUser?.password == password){
    user=currentUser;
    break;
  }
}

if(user != null){
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isloggedIn', true);

  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage(),));

}
else{
  showDialog(
    context: context, 
    builder: (context){
      return AlertDialog(
        title : const Text("error"),
        content: const Text("invalid email or password"),
        actions: [
          TextButton(onPressed:() => Navigator.pop(context), 
          child: Text("Ok"))
        ],
      );
    });
}



}

}