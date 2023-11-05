// ignore_for_file: prefer_const_constructors

//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:medilink/admin/pages/dashboard.dart';
import 'package:medilink/guest/pages/login.dart';
import 'package:email_auth/email_auth.dart';
import 'package:medilink/user/mainpage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  late EmailAuth emailAuth;

   @override
  void initState() {
    super.initState();
    // Initialize the package
    emailAuth =  EmailAuth(
      sessionName: "Signup session",
    );
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController=TextEditingController();
  final TextEditingController _dobController=TextEditingController();
  String? selectedGender;
  final List<String> genderOptions = ['Male', 'Female', 'Others'];
  // final TextEditingController _genderController=TextEditingController();
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _otpController=TextEditingController();


  // a Boolean function to verify if the Data provided is true
   verify() {
    print(emailAuth.validateOtp(
        recipientMail: _emailController.value.text,
        userOtp: _otpController.value.text)
        );
  }

    void sendOtp() async {
    bool result = await emailAuth.sendOtp(
        recipientMail: _emailController.value.text, otpLength: 5);
    if (result) {
      // using a void function because i am using a 
      // stateful widget and seting the state from here.
      setState(() {
        bool submitValid = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

       appBar: AppBar(
        //title: Text("Your personal details"),
      ),

    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Image.network('https://i.ibb.co/YZWjL9Y/Screenshot-2023-10-22-204311-removebg-preview.png',
                width: 200,),
            SizedBox(height: 40,),
            Form(
              key: _formKey,
              child: Column(
              children: [
    
                //full name
                TextFormField(
                  validator: validateFullName,
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: "Full Name"
                  ),
                ),
    
                SizedBox(height: 20,),
    
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
                    hintText: "Date Of Birth"
                  ),
                  readOnly: true,
                  onTap: (){
                    //print("date picker");
                    _selectDate(context);
                     },
                ),
    
                SizedBox(height: 20,),
    
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
                      selectedGender=newValue;
                    });
                   },
                   decoration: InputDecoration(
                    hintText: "Gender"
                   ),),
    
                   SizedBox(height: 20,),
    
                   //email 
                TextFormField(
                  validator:validateEmail ,
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintText: "email"
                  ),
                ),
                //otp
                TextButton(onPressed: (){
                  sendOtp();
                }, child: Text("get OTP")),

                //for otp entry
                TextFormField(
                  controller: _otpController,
                  decoration: InputDecoration(
                    hintText: "enter OTP"
                  ),
                ),
                 TextButton(onPressed: (){
                  verify();
                }, child: Text("verify OTP")),
               SizedBox(height: 30,),

               ElevatedButton(onPressed: (){
                   loginCheck();
                    //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));

                },
                 style:ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 9, 212, 114),
                  
                 ),
                 child: Text("Proceed",style: TextStyle(
                  color: Colors.white
                 ),)
                 ),

              SizedBox(height: 15,),

              //to login
              TextButton(onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
              }, child: Text("Already has an account ?")),

              TextButton(onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => MainPage(),));
              }, child: Text("user")),
              TextButton(onPressed: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => DashBoard(),));
              }, child: Text("dashboard")),
              
              ],
            ))
          ],
          
        ),
      ),
    ),

  



    );
  }

  void loginCheck() {
  // Check if the form is valid
  if (_formKey.currentState!.validate()) {
    // All form fields are valid, proceed with the login or registration logic here
    // You can access the form field values using the respective controllers
    final String fullName = _nameController.text;
    final String dateOfBirth = _dobController.text;
    final String gender = selectedGender ?? ""; // Gender can be null
    final String email = _emailController.text;
    final String otp = _otpController.text;

    // Perform your logic here, e.g., API requests, registration, etc.

    // For example, you can print the values for testing
    print('Full Name: $fullName');
    print('Date of Birth: $dateOfBirth');
    print('Gender: $gender');
    print('Email: $email');
    print('OTP: $otp');

    // After successful registration or login, you can navigate to the next screen.
    // Replace 'NextScreen' with the screen you want to navigate to.
    //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}



  Future<void> _selectDate(BuildContext context) async {
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


//to validate full name
String? validateFullName(String? value) {
  // Trim the value to remove leading and trailing spaces
  final trimmedValue = value?.trim();

  if (trimmedValue == null || trimmedValue.isEmpty) {
    return 'Full Name is required';
  }

  final RegExp nameRegExp = RegExp(r'^[a-zA-Z ]+$');

  if (!nameRegExp.hasMatch(trimmedValue)) {
    return 'Full Name can only contain letters and spaces';
  }

  return null; // Return null if the Full Name is valid
}

//to validate email
String? validateEmail(String? value) {
  // Trim the value to remove leading and trailing spaces
  final trimmedValue = value?.trim();

  if (trimmedValue == null || trimmedValue.isEmpty) {
    return 'Email is required';
  }

  final RegExp emailRegExp = RegExp(
    r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$',
  );

  if (!emailRegExp.hasMatch(trimmedValue)) {
    return 'Invalid email address';
  }

  return null; // Return null if the email is valid
}


}