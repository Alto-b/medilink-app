// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:medilink/admin/pages/dashboard.dart';
import 'package:medilink/guest/db/user_functions.dart';
import 'package:medilink/guest/model/usermodel.dart';
import 'package:medilink/guest/pages/login.dart';
import 'package:email_auth/email_auth.dart';
import 'package:medilink/user/mainpage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  //late EmailAuth emailAuth;

   @override
  // void initState() {
  //   super.initState();
  //   // Initialize the package
  //   emailAuth =  EmailAuth(
  //     sessionName: "Signup session",
  //   );
  // }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController=TextEditingController();
  final TextEditingController _dobController=TextEditingController();
  String? selectedGender;
  final List<String> genderOptions = ['Male', 'Female', 'Others'];
  //final TextEditingController _genderController=TextEditingController();
  final TextEditingController _emailController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  final TextEditingController _cpasswordController=TextEditingController();


  //a Boolean function to verify if the Data provided is true
  //  verify() {
  //   print(emailAuth.validateOtp(
  //       recipientMail: _emailController.value.text,
  //       userOtp: _otpController.value.text)
  //       );
  // }

  //   void sendOtp() async {
  //   bool result = await emailAuth.sendOtp(
  //       recipientMail: _emailController.value.text, otpLength: 5);
  //   if (result) {
  //     // using a void function because i am using a 
  //     // stateful widget and seting the state from here.
  //     setState(() {
  //       bool submitValid = true;
  //     });
  //   }
  // }

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
            SizedBox(height: 30,),
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
                    //label: Text("dob"),
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
                      selectedGender=newValue!;
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
                    hintText: "Email"
                  ),
                ),
                //otp
                // TextButton(onPressed: (){
                //    //sendOtp();
                // }, child: Text("get OTP")),

                //for otp entry
                // TextFormField(
                //   controller: _otpController,
                //   decoration: InputDecoration(
                //     hintText: "enter OTP"
                //   ),
                // ),
                //  TextButton(onPressed: (){
                //    //verify();
                // }, child: Text("verify OTP")),
               SizedBox(height: 30,),
               //password
               TextFormField(
                  validator:validatepassword ,
                  keyboardType: TextInputType.emailAddress,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: "Password"
                  ),
                ),
                 SizedBox(height: 30,),
               //confirm password
               TextFormField(
                  validator: validatecpassword ,
                  keyboardType: TextInputType.emailAddress,
                  controller: _cpasswordController,
                  decoration: InputDecoration(
                    hintText: "Confirm Password"
                  ),
                ),
                SizedBox(height: 20,),

               ElevatedButton(onPressed: (){
                   addUserbutton();
                   setState(() {
                     
                   });
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

//   void signup() {
//   // Check if the form is valid
//   if (_formKey.currentState!.validate() && _passwordController.text==_cpasswordController.text) {
//     final String fullName = _nameController.text;
//     final String dateOfBirth = _dobController.text;
//     final String gender = selectedGender ?? ""; 
//     final String email = _emailController.text;
//     final String pass = _passwordController.text;
//     final String cpass = _cpasswordController.text;

//   final _user=UserModel(fullname: fullName, dob: dateOfBirth, gender: gender, email: email, password: pass);
//   addUSer(_user);
//   print("user added");
//   setState(() {
    
//   });

//     // print('Full Name: $fullName');
//     // print('Date of Birth: $dateOfBirth');
//     // print('Gender: $gender');
//     // print('Email: $email');
//     // print('Password: $pass');
//     // print('cPassword: $cpass');

//     //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
//   }
// }



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

//to validate email
String? validateEmail(String? value) {
  
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

  return null; 
}

//to validate password
String? validatepassword(String? value){
  final trimmedValue = value?.trim();

  if(trimmedValue == null || trimmedValue.isEmpty){
    return 'Cannot be empty';
  }
  return null;
}

//to validate conform password
String? validatecpassword(String? value){
  final trimmedValue = value?.trim();

  if(trimmedValue == null || trimmedValue.isEmpty){
    return 'Cannot be empty';
  }
  if(trimmedValue!=_passwordController.text){
    return 'Password must watch';
  }
  return null;
}

// //to sign up user

// Future<void> userAddButton()async{

//   final _name=_nameController.text.trim();
//   final _dob=_dobController.text.trim();
//   final _gender=selectedGender;
//   final _email=_emailController.text.trim();
//   final _password=_passwordController.text.trim();

//   final _user=UserModel(fullname: _name, dob: _dob, gender: _gender, email: _email, password: _password);
//   addUSer(_user);
// }

//to add user
    Future<void> addUserbutton() async{
      final String fullName = _nameController.text.trim();
    final String dateOfBirth = _dobController.text.trim();
    final String gender = selectedGender ?? ""; 
    final String email = _emailController.text.trim();
    final String pass = _passwordController.text.trim();
    final String cpass = _cpasswordController.text.trim();

      if(_formKey.currentState!.validate() && _passwordController.text==_cpasswordController.text){
        //print('empty');
        //print('$_dept');
      final _user=UserModel(fullname: fullName, dob: dateOfBirth, gender: gender, email: email, password: pass);
      addUser(_user);
       
      }
      else{
        showSnackBar(context, 'User registration failed!');
      }
    }

//code for snackbar    
void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: 3), 
    ),
  );
}

}
