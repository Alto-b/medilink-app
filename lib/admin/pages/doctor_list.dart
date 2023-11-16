import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:medilink/admin/db/doctor_functions.dart';
import 'package:medilink/admin/model/doctor_model.dart';
import 'package:medilink/styles/custom_widgets.dart';

class DoctorListPage extends StatefulWidget {
  const DoctorListPage({super.key});

  @override
  State<DoctorListPage> createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {

  @override
  void initState(){
    super.initState();
     getDoctor();
  }



  @override
  Widget build(BuildContext context) {
//  getDoctor();
   

    return Scaffold(

      appBar: AppBar(
        title: Text("OUR DOCTORS",style: appBarTitleStyle(),),

      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              //Text("list of doctors"),
        //listener
                  Container(
                    //color: Colors.red,
                      height: 690,
                      child: ValueListenableBuilder(
                        valueListenable: doctorListNotifier,
                        builder: (BuildContext ctx, List<DoctorModel> doctorList,Widget? child) {
        
                        return ListView.separated(
                        itemBuilder:((context, index) {
                          final data=doctorList[index];
        
                          return Slidable(
                                  endActionPane: ActionPane(
                                    motion:DrawerMotion() ,
                                 children: [
                                  //delete
                                  SlidableAction(onPressed: (context) {
                                    deleteDoctor(data.id!);
                                   
                                  },
                                  icon:Icons.delete,
                                  backgroundColor: Color.fromARGB(255, 248, 3, 3),
                                  ),
                                  //edit
                                   SlidableAction(onPressed: (context) {
                                    // deleteDept(data.id!);
                                    // _departmentController.clear();
                                  },
                                  icon:Icons.edit,
                                  backgroundColor: Color.fromARGB(255, 3, 56, 248),
                                  ),
                                 ] ),
                               
                                          
            
                            child: Container(
                              child: ListTile(
                                onTap: () {
                                  
                                },
                                //tileColor: Colors.blue,
                                horizontalTitleGap: 10,
                                //contentPadding: EdgeInsets.all(5),
                                //leading: Text("${index+1}",),
                                leading: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: FileImage(File(data.photo)),
                                ),
                                title: Text("Dr.${data.name}",style:doctorListTitle(),),
                                contentPadding: EdgeInsets.all(5),      
                                
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Specialization: ${data.specialization}",style: doctorListSubtitle(),),
                                    Text("Qualification: ${data.qualification}",style: doctorListSubtitle(),),
                                    Text("Hospital: ${data.hospital}",style: doctorListSubtitle(),),
                                    Text("Join date: ${data.doj}",style: doctorListSubtitle(),),
                                    Text("Date of birth: ${data.dob}",style: doctorListSubtitle(),),
                                    

                                  ],
                                ),                    
                              ),
                            ),
                            
                          );
                        }) , 
                       separatorBuilder: ((context, index) {
                        return const Divider();
                        }), 
                      itemCount:doctorList.length);
                     }, ),
                    ),
            ],
          ),
        ),
      ),
    );
  }



}