// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:medilink/admin/db/feedback_functions.dart';
import 'package:medilink/admin/model/feedback_model.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController=TextEditingController();
  final TextEditingController _contentController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(title: Text("feedback")),


      //body
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children:  [
              //form
              Form(
                key: _formKey,
                child: Column(
                children: [
                    //text
                    Text('" Your feedbacks are valuable to us "',style: TextStyle(fontSize: 15),),
                    SizedBox(height: 30,),
      
                  //title txt
                  TextFormField(
                    controller: _titleController,
                    validator: validateEmail,
                    decoration: InputDecoration(
                      hintText:"Email"
                      ),
                  ),
                  SizedBox(height: 30,),
      
                  //content txt
                  TextFormField(
                    controller: _contentController,
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return 'Cannot be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                    hintText: "Content",
                    ),
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                  ),
                  SizedBox(height: 30,),
      
                  ElevatedButton(onPressed: (){
                    //submitFeedback();
                    submit();
                    // _titleController.clear();
                    // _contentController.clear();
                  }, child: Text("Submit"))
                    ],
                  )
                )
             
            ],
          ),
        ),
      )
    );
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

// //to submit feedback
void submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      submitFeedback();
      
    }
  }

//to submit feedback
Future<void> submitFeedback()async{
  final title=_titleController.text.trim();
  final content=_contentController.text.trim();

  if(title.isEmpty || content.isEmpty ){
    return showDialog(
    context: context, 
    builder: (context){
      return AlertDialog(
       // title : const Text("error"),
        content: const Text("Fields cannot be empty"),
        actions: [
          TextButton(onPressed:() => Navigator.pop(context), 
          child: Text("Ok"))
        ],
      );
    });
  }
  else{
    final feedback=FeedBackModel(title: title, content: content,date: DateTime.now().toString());
    addFeedbacks(feedback);
     _titleController.clear();
     _contentController.clear();
  }

}

}