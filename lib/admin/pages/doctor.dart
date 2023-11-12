// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medilink/admin/db/doctor_functions.dart';
import 'package:medilink/admin/model/doctor_model.dart';

class AddDoctor extends StatefulWidget {
  const AddDoctor({super.key});

  @override
  State<AddDoctor> createState() => _AddDoctorState();
}

class _AddDoctorState extends State<AddDoctor> {

  final _formKey = GlobalKey<FormState>();
  File? _selectedImage;
  final TextEditingController _nameController=TextEditingController();
  final TextEditingController _qualificationController=TextEditingController();
  final TextEditingController _dobController=TextEditingController();
  final TextEditingController _dojController=TextEditingController();
  String? selectedGender;
  final List<String> genderOptions = ['Male', 'Female', 'Not Specified'];
  String? selectedHospital;
  final List<String> hospitalOptions = ['Male', 'Female', 'Not Specified'];
  String? selectedQualification;
  final List<String> qualificationOptions = ['Male', 'Female', 'Not Specified'];
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("ADD DOCTORS") ,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Form(
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
                          ? Image.file(_selectedImage!, fit: BoxFit.fill,)
                          : Center(
                              child: Icon(Icons.add_a_photo))),
                ),
                Column(children: [
                  IconButton(
                      onPressed: () {
                        _pickImage();
                      },
                      icon: Icon(Icons.photo_library_outlined),tooltip: "select from gallery",),
                  IconButton(
                      onPressed: () {
                        _photoImage();
                      },
                      icon: Icon(Icons.camera_alt_outlined),tooltip: "open camera")
                ])
              ]),SizedBox(height: 20,),
      
//full name
              TextFormField(
                controller: _nameController,
                validator: validateFullName,
                decoration: InputDecoration(
                  hintText: "Full Name",
                ),
              ),SizedBox(height: 20,),

//gender selection
                DropdownButtonFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "select a gender";
                    }
                    return null;
                  },
                  value: selectedGender,
                  items:genderOptions.map((String gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender)
                      );
                  }).toList() ,
                   onChanged: (String? newValue){
                    setState(() {
                      selectedGender=newValue!;
                    });
                   },
                   decoration: InputDecoration(
                    hintText: "Gender"
                   ),),SizedBox(height: 20,),
      
//qualification
              TextFormField(
                controller: _qualificationController,
                validator: validateQualification,
                decoration: InputDecoration(
                  hintText: "Qualification",
                ),
              ),SizedBox(height: 20,),
      
//date of birth
             TextFormField(
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "select date of birth";
                      }
                      return null;
                    },
                    controller: _dobController,
                    decoration: InputDecoration(
                      //label: Text("dob"),
                      hintText: "Date Of Birth"
                    ),
                    readOnly: true,
                    onTap: (){
                      //print("date picker");
                      _selectDob(context);
                       },
                  ),SizedBox(height: 20,),
      
//date of join
             TextFormField(
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "select date of join";
                      }
                      return null;
                    },
                    controller: _dojController,
                    decoration: InputDecoration(
                      //label: Text("dob"),
                      hintText: "Date Of Join"
                    ),
                    readOnly: true,
                    onTap: (){
                      //print("date picker");
                      _selectDoj(context);
                       },
                  ),SizedBox(height: 20,),

//hospital selection
                DropdownButtonFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "select Hospital";
                    }
                    return null;
                  },
                  value: selectedGender,
                  items:genderOptions.map((String gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender)
                      );
                  }).toList() ,
                   onChanged: (String? newValue){
                    setState(() {
                      selectedGender=newValue!;
                    });
                   },
                   decoration: InputDecoration(
                    hintText: "Hospital"
                   ),),SizedBox(height: 20,),

//department selection
                DropdownButtonFormField(
                  validator: (value){
                    if(value == null || value.isEmpty){
                      return "select Specialization";
                    }
                    return null;
                  },
                  value: selectedGender,
                  items:genderOptions.map((String gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(gender)
                      );
                  }).toList() ,
                   onChanged: (String? newValue){
                    setState(() {
                      selectedGender=newValue!;
                    });
                   },
                   decoration: InputDecoration(
                    hintText: "Specialization"
                   ),),SizedBox(height: 20,),

//submit button
                ElevatedButton(onPressed: (){
                  submit();
                }, child: Text("ADD DOCTOR"))
        
              
        
                  ],
        
              ))
            ],
          ),
        ),
      ),
    );
  }
//to validate full name
String? validateFullName(String? value) {
  
  final trimmedValue = value?.trim();

  if (trimmedValue == null || trimmedValue.isEmpty) {
    return 'Full Name is required';
  }

  final RegExp nameRegExp = RegExp(r'^[a-zA-Z ]+$');

  if (!nameRegExp.hasMatch(trimmedValue)) {
    return 'Full Name can only contain letters and spaces';
  }

  return null; 
}

//to validate full name
String? validateQualification(String? value) {
  
  final trimmedValue = value?.trim();

  if (trimmedValue == null || trimmedValue.isEmpty) {
    return 'Qualification is required';
  }
  return null; 
}
  
//IMAGE THROUGH CAMERA
Future<void> _photoImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
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

//to select dob
 Future<void> _selectDob(BuildContext context) async {
    //print("dob clicked");
  DateTime selectedDate = DateTime.now(); // Initialize with the current date.

  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime(2000),
    firstDate: DateTime(1900), // Start date for selection
    lastDate: DateTime(2023), // End date for selection
  );

  if (picked != null && picked != selectedDate) {
    // Update the selected date
    setState(() {
      selectedDate = picked;
      _dobController.text = selectedDate.toLocal().toString().split(' ')[0];
    });
  }
}

//to select doj
 Future<void> _selectDoj(BuildContext context) async {
    //print("dob clicked");
  DateTime selectedDate = DateTime.now(); // Initialize with the current date.

  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime(2000),
    firstDate: DateTime(1900), // Start date for selection
    lastDate: DateTime(2023), // End date for selection
  );

  if (picked != null && picked != selectedDate) {
    // Update the selected date
    setState(() {
      selectedDate = picked;
      _dojController.text = selectedDate.toLocal().toString().split(' ')[0];
    });
  }
}

Future<void> submit() async{
  final String name=_nameController.text.trim();
  final String gender=selectedGender ?? "";
  final String qualification=_qualificationController.text.trim();
  final String dob=_dobController.text.trim();
  final String doj=_dojController.text.trim();
  final String hospital=selectedHospital ?? "";
  final String specialization=selectedQualification ?? "";

  if(_formKey.currentState!.validate()){
    final _doctor=DoctorModel(name: name, gender: gender, qualification: qualification, dob: dob, doj: doj, hospital: hospital, specialization: specialization);
    addDoctor(_doctor);
    showSnackBarSuccess(context, "Details added successfully!");
  }
  else{
      showSnackBarFailed(context, "Couldn't add details!");
  }
  

}

//code for snackbar success  
void showSnackBarFailed(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3), 
    ),
  );
}

//code for snackbar success  
void showSnackBarSuccess(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3), 
    ),
  );
}

}


