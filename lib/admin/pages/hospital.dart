// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:medilink/admin/db/hosp_functions.dart';
import 'package:medilink/admin/model/hospmodel.dart';

class HospitalPage extends StatefulWidget {
  const HospitalPage({super.key});

  @override
  State<HospitalPage> createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {

  final _formKey=GlobalKey<FormState>();
  final _hospitalController=TextEditingController(); 


  @override
  Widget build(BuildContext context) {

    getHosp();

    return Scaffold(

      //appbar
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Manage hospitals",style: TextStyle(color: Colors.white)),
      ),

      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    SizedBox(height: 50,),
                    //textformfield     
                      TextFormField(
                        validator: (value) {
                               if (value == null || value.isEmpty) {
                                 return 'Cannot be empty';
                                }
                                 if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                                     return 'Only characters are allowed';
                                    }
                                   return null;
                               },
                               controller: _hospitalController,
                               decoration: InputDecoration(
                                hintText: "Enter hospital"
                               ),
                      ),SizedBox(height: 20,),
        
                      //add button
                       ElevatedButton(
                          onPressed: () {
                            addHospitalButton();
                            _hospitalController.clear();
                          },
                      child: Text("Add"),
                    ),
                      SizedBox(height: 20,),

                  //list

                  SizedBox(
                    height: 500,
                    child: ValueListenableBuilder(
                      valueListenable: hospListNotifier,
                      builder:(BuildContext ctx,List<HospModel> hospitalList,Widget? child){
                        return ListView.separated(
                          itemBuilder: (ctx,index){
                          final data = hospitalList[index];

                        return Slidable(
                          child: ListTile(
                            leading: Text("${index+1}"),
                            title: Text(data.hosp),
                            trailing: IconButton(onPressed: (){
                              if(data.id!=null){
                                deleteHosp(data.id!);
                              }
                              else{
                               // print("hospital id is null");
                              }
                            }, icon: Icon(Icons.delete)),
                          ),
                        );
                      }, 
                      separatorBuilder: (ctx,index){
                        return const Divider();
                      }, 
                      itemCount: hospitalList.length);
                      } ,
                     
                    ),
                  )
                  ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addHospitalButton()async{
    final _hosp = _hospitalController.text.trim();
    if(_hosp.isEmpty){
      return ;
    }
    final _hospital = HospModel(hosp: _hosp);
    //print(_hosp);
    addHosp(_hospital);
  }
}