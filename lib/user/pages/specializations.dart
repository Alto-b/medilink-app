// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:medilink/admin/db/dept_functions.dart';
import 'package:medilink/admin/model/deptmodel.dart';
import 'package:medilink/styles/custom_widgets.dart';

class SpecializationPage extends StatefulWidget {
  const SpecializationPage({super.key});

  @override
  State<SpecializationPage> createState() => _SpecializationPageState();
}

class _SpecializationPageState extends State<SpecializationPage> {

final  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    getDepartment();
    
    return Scaffold(

      appBar: AppBar(
        title: Text("OUR SPECIALIZATIONS",style: appBarTitleStyle(),),
      ),


      body:SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
                children: [
                  //logo
                  // Image.network('https://i.ibb.co/YZWjL9Y/Screenshot-2023-10-22-204311-removebg-preview.png',
                  //               width: 200,),
      
                  //search field
                  SizedBox(height: 30,),
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50)
                        ),
                        hintText: "Search specializations"
                    ),
                    onChanged: (query) {
                      setState(() {
                        
                      });
                    },
                  ),
                  SizedBox(height: 40,),

                  //listing specialization
                  SizedBox(
                  height: 500,
                  child: ValueListenableBuilder(
                    valueListenable: deptListNotifier,
                    builder: (BuildContext ctx, List<DepartmentModel> departmentList,Widget? child) {
                   
                   //search part
                   final filteredDepartments=_searchController.text.isEmpty
                   ?departmentList
                   :departmentList.where((dept) => 
                   dept.dept.toLowerCase().contains(_searchController.text.toLowerCase())).toList();
                   
                   
                    return ListView.separated(
                    itemBuilder:((context, index) {
                      final data=departmentList[index]; 
                        return SizedBox(
                          //height: 500,
                          child: Container(
                            decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(15),
                               color: Colors.blue[400]
                            ),
                            child: ListTile(
                              //tileColor: Colors.blue,
                              horizontalTitleGap: 20,
                              contentPadding: EdgeInsets.all(5),
                              //leading: Text("${index+1}"),
                              // title: Align(child: Text(data.dept)),     
                              title: Align(child: Text(data.dept,style: TextStyle(fontSize: 20,fontWeight:FontWeight.w500,color: Colors.white ),)),                          
                            ),
                          ),
                        );
                    }) , 
                   separatorBuilder: ((context, index) {
                    return const Divider(color: Colors.white,);
                    }), 
                  itemCount:filteredDepartments.length);
                 }, ),
                ),
                ],
            ),
          ),
        ),
      )

    );
  }
}