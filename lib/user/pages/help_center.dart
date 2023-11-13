// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medilink/styles/custom_widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _subjectController=TextEditingController();
  final TextEditingController _contentController=TextEditingController();
  final TextEditingController _bodyController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("HELP CENTER",style: appBarTitleStyle(),),
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Write to Us !"),
            Text(""),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: _formKey,
                child: Column(
                children: [
            
                  TextFormField(
                    controller:_subjectController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Subject"
                    ),
                  ),
            
                 TextFormField(
                    controller:_bodyController,
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      hintText: "Content"
                    ),
                  ),
            
                 ElevatedButton(onPressed: (){
                  launchEmail();
                 }, child: Text("Sent"))
            
                      
                  
                ],
              )),
            )
          ],
        ),
      ),
    );
  }

  Future<void> launchEmail() async {

    final subject=_subjectController.text.trim();
    final body=_bodyController.text.trim();

    final Uri _emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'nu3347145@gmail.com', // Add your recipient email address here
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );

    // if (await canLaunchUrl(_emailLaunchUri)) {
      print("trying to send");
      await launchUrl(_emailLaunchUri);
      print("sended");
    // } 
    // else {
    //   //throw 'Could not launch email app';
    //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    //   content: Text('Error launching email app'),));
    // }
  }





}