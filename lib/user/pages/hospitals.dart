// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:medilink/admin/db/hosp_functions.dart';
import 'package:medilink/admin/model/hospmodel.dart';

class HospitalPage extends StatefulWidget {
  const HospitalPage({super.key});

  @override
  State<HospitalPage> createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {

final  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //appbar
      appBar: AppBar(
        title: Text("Our hospitals"),
      ) ,

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
                        hintText: "Search hospitals"
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
                    valueListenable: hospListNotifier,
                    builder: (BuildContext ctx, List<HospModel> hospitalList,Widget? child) {
                   
                   //search part
                   final filteredHospitals=_searchController.text.isEmpty
                   ?hospitalList
                   :hospitalList.where((hosp) => 
                   hosp.hosp.toLowerCase().contains(_searchController.text.toLowerCase())).toList();
                   
                   
                    return ListView.separated(
                    itemBuilder:((context, index) {
                      final data=hospitalList[index]; 
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
                              title: Align(child: Text(data.hosp,style: TextStyle(fontSize: 20,fontWeight:FontWeight.w500,color: Colors.white ),)),                          
                            ),
                          ),
                        );
                    }) , 
                   separatorBuilder: ((context, index) {
                    return const Divider(color: Colors.white,);
                    }), 
                  itemCount:filteredHospitals.length);
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