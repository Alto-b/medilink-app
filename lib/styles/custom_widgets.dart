

// ignore_for_file: prefer_const_constructors

  import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';


//appbar title text for user
TextStyle appBarTitleStyle() => GoogleFonts.play(
      fontWeight: FontWeight.w600,
      letterSpacing: 2,
      fontSize: 18,
      color: Colors.black.withOpacity(0.7)
      );

//about us main text
//ubuntu
  TextStyle aboutUsText() => GoogleFonts.wixMadeforDisplay(
    fontWeight: FontWeight.w600,
    fontSize: 20,

    );

//about us card name
  TextStyle cardname() => TextStyle(
    color: const Color.fromARGB(255, 113, 124, 185),
    fontWeight: FontWeight.w700);

//about us card content
  TextStyle cardcontent() => TextStyle();

//about us card title
  TextStyle cardtitle() => TextStyle(
    fontSize: 20,
    color: Colors.indigo,
    fontWeight: FontWeight.w500);


//settings list tile title
TextStyle listtileTitleStyle() => GoogleFonts.wallpoet();


//profile page box decoration
BoxDecoration optionsBoxDecoration() => BoxDecoration(
    color: Colors.white,
    // border: Border.all(
    //   //color: Colors.blueGrey,width: 0.5
    //   ),
      borderRadius: BorderRadius.circular(30),
      boxShadow:[
        BoxShadow(
          spreadRadius: 1,
           blurRadius: 3,
           //offset: Offset(-3, -1),
          color:Colors.grey.withOpacity(.5),
          )] );


//profile page to set gender icon
Icon getGenderIcon(String gender) {
  if (gender.toLowerCase() == 'male') {
    return Icon(Icons.male,color: Colors.blue);
  } else if (gender.toLowerCase() == 'female') {
    return Icon(Icons.female,color: Colors.pink);
  } else {
    return Icon(Icons.person,color: Colors.grey);
  }
}

//profile page text style
TextStyle ProfileTextStyle() => TextStyle(fontWeight: FontWeight.w600);