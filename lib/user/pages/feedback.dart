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
  
  final GlobalKey _formKey=GlobalKey<FormState>();
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
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return 'Cannot be empty';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText:"Title"
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
                    submitFeedback();
                    _titleController.clear();
                    _contentController.clear();
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

Future<void> submitFeedback()async{
  final title=_titleController.text.trim();
  final content=_contentController.text.trim();

  if(title.isEmpty || content.isEmpty){
    return ;
  }
  else{
    final feedback=FeedBackModel(title: title, content: content,date: DateTime.now().toString());
    addFeedbacks(feedback);
  }

}

}