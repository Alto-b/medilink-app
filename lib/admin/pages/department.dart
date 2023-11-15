// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medilink/admin/db/dept_functions.dart';
import 'package:medilink/admin/model/deptmodel.dart';
import 'package:medilink/styles/custom_widgets.dart';


class DepartmentPage extends StatefulWidget {
  const DepartmentPage({super.key});

  @override
  State<DepartmentPage> createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {

  final _departmentController=TextEditingController();
  final _editController=TextEditingController();
    final _formKey = GlobalKey<FormState>();
    final _formKey1 = GlobalKey<FormState>();

    File? _selectedImage;

// //to generate a unique key
//     int generateUniqueId() {
//   return DateTime.now().microsecond;
// }

//to add department
    Future<void> addDepartmentButton() async{
      final _dept=_departmentController.text.trim();
      final imagepath=_selectedImage!.path;
      if(_dept.isEmpty){
        //print('empty');
        return ;
      }
      else{
      //print('$_dept');
      final _department=DepartmentModel( dept: _dept,photo:imagepath ,id:-1);
      addDepartment(_department);
      }
    }

  @override
  Widget build(BuildContext context) {

    getDepartment();

    return Scaffold(
      
      //appbar
      appBar: AppBar( 
        title: Text("DEPARTMENTS",style:appBarTitleStyle()),
      ),

      //body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
//               Form(
//                 key: _formKey,
//                 child: Column(
//                 children: [
//                   SizedBox(height: 20,),
// //department txt
//                   TextFormField(
//                     validator: (value){
//                       if(value==null || value.isEmpty){
//                         return 'cannot be empty';
//                       }
//                       if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
//                          return 'Only characters are allowed';
//                       }
//                       return null;
//                     },
//                     controller: _departmentController,
//                     decoration: InputDecoration(
//                       hintText: "Enter department"
//                     ),
//                   ),
//                   SizedBox(height: 20,),

// //button          
//                 ElevatedButton(onPressed: (){
//                   //print("add button clicked");
//                   addDepartmentButton();
//                   _departmentController.clear();
//                 },
//                  child: Text("Add")),
//                  SizedBox(height: 40,)
        
//                 ],
//               )),


              //listener

              SizedBox(
                  height: 500,
                  child: ValueListenableBuilder(
                    valueListenable: deptListNotifier,
                    builder: (BuildContext ctx, List<DepartmentModel> departmentList,Widget? child) {

                    return ListView.separated(
                    itemBuilder:((context, index) {
                      final data=departmentList[index];

                      return Slidable(
                              endActionPane: ActionPane(
                                motion:DrawerMotion() ,
                             children: [
                              //edit
                              SlidableAction(onPressed: (context) {

                             _editSheet(context,data.dept,data.id!);
                                 },
                              icon:Icons.edit,
                              backgroundColor: Color.fromARGB(255, 10, 112, 196),
                              ),
                              //delete
                              SlidableAction(onPressed: (context) {
                                deleteDept(data.id!);
                                _departmentController.clear();
                              },
                              icon:Icons.delete,
                              backgroundColor: Color.fromARGB(255, 248, 3, 3),
                              ),
                             ] ),
                           
                                      
    
                        child: Container(
                          child: ListTile(
                            horizontalTitleGap: 20,
                            contentPadding: EdgeInsets.all(5),
                            leading: Text("${index+1}"),
                            title: Row(
                              children: [
                                CircleAvatar(
                              radius: 25,
                              backgroundColor: Colors.transparent,
                              backgroundImage: FileImage(File(data.photo)),
                            ),    SizedBox(width: 20,),
                                Text(data.dept),
                              ],
                            ),                        
                          ),
                        ),
                        
                      );
                    }) , 
                   separatorBuilder: ((context, index) {
                    return const Divider();
                    }), 
                  itemCount:departmentList.length);
                 }, ),
                ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(onPressed: (){
        _addSheet(context);
      },
            mini: true,
            child: Icon(Icons.add),),
    );
  }
 //to add section
  void _addSheet(BuildContext context){
      showModalBottomSheet(context: context, builder:(context) {
        
       return Container(             
        child: Padding(
           padding: const EdgeInsets.all(25.0),                   child: Form(
          key: _formKey,
                child: Column(
                children: [
                  //add photo
        
                     Row(
                      children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        border: Border.all(width: 2, color: const Color.fromARGB(255, 18, 18, 18)),
                        //borderRadius: BorderRadius.circular(10)
                      ),
                      child: _selectedImage != null
                          ? Image.file(_selectedImage! as File, fit: BoxFit.fill,)
                          : Center(
                              child: Icon(Icons.add_a_photo))),
                ),
                Column(children: [
                  IconButton(
                      onPressed: () {
                        _pickImage();
                        
                      },
                      icon: Icon(Icons.photo_library_outlined),tooltip: "select from gallery",),
                  // IconButton(
                  //     onPressed: () {
                  //       _photoImage();
                  //     },
                  //     icon: Icon(Icons.camera_alt_outlined),tooltip: "open camera")
                ])
              ]),SizedBox(height: 20,),

                  SizedBox(height: 20,),
//department txt
                  TextFormField(
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'cannot be empty';
                      }
                      if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
                         return 'Only characters are allowed';
                      }
                      return null;
                    },
                    controller: _departmentController,
                    decoration: InputDecoration(
                      hintText: "Enter department"
                    ),
                  ),
                  SizedBox(height: 20,),

//button          
                ElevatedButton(onPressed: (){
                  //print("add button clicked");
                  addDepartmentButton();
                  
                  _departmentController.clear();
                  Navigator.pop(context);
                },
                 child: Text("Add")),
                 SizedBox(height: 40,)
        
                ],
              )),
                                    ),
                                 );
                               }, );
  }


 //to edit section
  void _editSheet(BuildContext context,String department,int id){
      showModalBottomSheet(context: context, builder:(context) {
        _editController.text=department;
                                 return Container(
                                  
                                    child: Padding(
                                      padding: const EdgeInsets.all(25.0),
                                      child: Form(
                                        key: _formKey1,
                                        child: Column(
                                          children: [
                                            TextFormField(
                                              controller: _departmentController,
                                              decoration: InputDecoration(
                                                border: UnderlineInputBorder(),
                                                hintText: "Add Department"
                                              ),
                                            ),SizedBox(height: 25,),
                                           
                                          ],
                                        ),
                                      ),
                                    ),
                                 );
                               }, );
  }

  //IMAGE FROM PHOTOS
Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }
}