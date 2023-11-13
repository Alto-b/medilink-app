// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:medilink/admin/db/appointment_functions.dart';
import 'package:medilink/admin/db/dept_functions.dart';
import 'package:medilink/admin/model/doctor_model.dart';
import 'package:medilink/guest/db/user_functions.dart';

class StatisticsPage extends StatefulWidget {
  const StatisticsPage({super.key});

  @override
  State<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends State<StatisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("STATISTICS"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
          ),
          itemCount: 2, // Number of items in the GridView
          itemBuilder: (context, index) {
            // You can customize each grid item based on the index
            switch (index) {
//user count
              case 0:
                return Container(
                  decoration: statsContainer(),
                  child: FutureBuilder<int>(
                    future: userStats(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        final userCount = snapshot.data!;
                        return Center(child: Text('User Count: $userCount'));
                      }
                    },
                  ),
                );
//appointment count
              case 1:
                return Container(
                  decoration: statsContainer(),
                  child: FutureBuilder<int>(
                    future: appointmentStats(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        final appointmentCount = snapshot.data!;
                        return Center(child: Text('Appointment Count: $appointmentCount'));
                      }
                    },
                  ),
                );
              default:
                return Container(); // Return an empty container for other indices
            }
          },
        ),
      ),
    );
  }

  BoxDecoration statsContainer() => BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: Colors.amber
  );
}
