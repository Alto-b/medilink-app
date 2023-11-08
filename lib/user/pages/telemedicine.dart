// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class TelemedicinePage extends StatefulWidget {
  const TelemedicinePage({super.key});

  @override
  State<TelemedicinePage> createState() => _TelemedicinePageState();
}

class _TelemedicinePageState extends State<TelemedicinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Telemedicine")),
      //backgroundColor: Colors.amber,
      body: Column(
        children: [
          Form(child: Column(
            children: [
              TextFormField(
                
               )
            ],
          ))
        ],
      ),
    );
  }
}