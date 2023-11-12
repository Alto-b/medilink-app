import 'package:flutter/material.dart';
import 'package:medilink/styles/custom_widgets.dart';

class MyAppointments extends StatefulWidget {
  const MyAppointments({super.key});

  @override
  State<MyAppointments> createState() => _MyAppointmentsState();
}

class _MyAppointmentsState extends State<MyAppointments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("MY APPOINTMENTS",style: appBarTitleStyle(),),
      ),
    );
  }
}