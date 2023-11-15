// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medilink/admin/db/hosp_functions.dart';
import 'package:medilink/admin/model/hospmodel.dart';
import 'package:medilink/styles/custom_widgets.dart';

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
        title: Text("OUR HOSPITALS",style: appBarTitleStyle()),
      ) ,

      body:SingleChildScrollView(
        child: Center(
          child: Column(
              children: [
                //logo
                // Image.network('https://i.ibb.co/YZWjL9Y/Screenshot-2023-10-22-204311-removebg-preview.png',
                //               width: 200,),
      
                //search field
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      
                      decoration: BoxDecoration(color: const Color.fromARGB(255, 255, 255, 255),
                       borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30)),
                       boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 10,
                            offset: Offset(0, 5)
                          )
                        ]
                      ),
                        child: Icon(Icons.search),
                    ),
                    Container(
                      height: 60,
                      width: 280,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomRight: Radius.circular(30)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 10,
                            offset: Offset(3, 4)
                          )
                        ]
                      ),
                      child:
                          TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(50),
                                  borderSide: BorderSide.none
                                ),
                                hintText: "Search hospitals"
                            ),
                            onChanged: (query) {
                              setState(() {
                                
                              });
                            },
                          ),
                       
                    ),
                  ],
                ),
                SizedBox(height: 40,),

                //listing specialization
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                  height: 800,
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
                          //height: 800,
                          child: Container(
                            decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(15),
                               color: Colors.blue[300]
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
                ),
              ],
          ),
        ),
      )
    );
  }


}