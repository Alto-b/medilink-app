// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:medilink/guest/pages/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text("login"),
        ),

        body: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Form(child: Column(
                children: [
                  SizedBox(height: 50,),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "email id "
                    ),
                  ),
                  TextButton(onPressed: (){
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUpPage(),));
                  }, child: Text("signup"))
                ],
              ))
            ],
          ),
        ),
     
    );
  }
}