// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:medilink/user/pages/about_us.dart';
import 'package:medilink/user/pages/book_appointment.dart';
import 'package:medilink/user/pages/my_appointments.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title:Image.network(
          'https://i.ibb.co/YZWjL9Y/Screenshot-2023-10-22-204311-removebg-preview.png',
          width: 120, ),
          centerTitle: true,
          toolbarHeight: 90,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            //carousal  
             CarouselSlider(
              options: CarouselOptions(
                height: 200, 
                enlargeCenterPage: true, 
                aspectRatio: 16/9, 
                //aspectRatio: 4/3,
                enableInfiniteScroll: true,
                autoPlay: true, 
                autoPlayInterval: Duration(seconds: 3), 
                autoPlayAnimationDuration: Duration(milliseconds: 1000), 
                autoPlayCurve: Curves.fastOutSlowIn, 
                //autoPlayCurve: Curves.easeIn,
                enlargeStrategy: CenterPageEnlargeStrategy.height, 
              ),
              items: [
                // Add your carousel items here, e.g., Container, Image, or any widget
                Container(
                  //color: Colors.red,
                  child: Center(child: Image.network('https://i.ibb.co/N2kV2r6/and-Heal-with-Medi-Link.png')),
                ),
                Container(
                  //color: Colors.blue,
                  child: Center(child: Image.network('https://i.ibb.co/y5Fs7Bg/2-with-Medi-Link.png')),
                ),
                Container(
                  //color: Colors.green,
                  child: Center(child: Image.network('https://i.ibb.co/wYHjX8Z/3-Medi-Link.png')),
                ),
              ],
            ),
            SizedBox(height: 30,),

           //row1

          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              child: Column(
                children: [
                  Row(                
                    //children: [ SizedBox(width: 15,) , Text("HOSPITAL",style: TextStyle(color: const Color.fromARGB(255, 0, 50, 92)),)],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                       //our hospitals
                      //SizedBox(width: 20,),
                      Container(
                        alignment: Alignment.center,
                        height: 100,width: 100,
                        decoration:BoxDecoration(border: Border.all(color: Colors.blueGrey),borderRadius: BorderRadius.circular(20),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.red,
                        //     offset: Offset(0, 4),
                        //     blurRadius: 10,
                        //     spreadRadius: -3
                        //   )
                        // ]
                        ) ,
                        child: Column(children: [
                          TextButton(onPressed: (){}, child: Column(
                            children: [
                              Icon(Icons.business,size: 50,),
                              Text("Our ",style: TextStyle(fontSize: 11),textAlign: TextAlign.center),
                              Text(" hospitals",style: TextStyle(fontSize: 11),textAlign: TextAlign.center),
                            ],
                          ))
                        ]),
                      ),
                      //our doctors
                      Container(
                        alignment: Alignment.center,
                        height: 100,width: 100,
                        decoration:BoxDecoration(border: Border.all(color: Colors.blueGrey),borderRadius: BorderRadius.circular(20)) ,
                        child: Column(children: [
                          TextButton(onPressed: (){}, child: Column(
                            children: [
                              Icon(Icons.star_border,size: 50,),
                              Text("Our",style: TextStyle(fontSize:11),textAlign: TextAlign.center),
                              Text("Specializations",style: TextStyle(fontSize: 10.5),textAlign: TextAlign.center),
                            ],
                          ))
                        ]),
                      ),
                      //our doctors
                      Container(
                        alignment: Alignment.center,
                        height: 100,width: 100,
                        decoration:BoxDecoration(border: Border.all(color: Colors.blueGrey),borderRadius: BorderRadius.circular(20)) ,
                        child: Column(children: [
                          TextButton(onPressed: (){}, child: Column(
                            children: [
                              Icon(Icons.group_outlined,size: 50,),
                              Text("Our ",style: TextStyle(fontSize:11),textAlign: TextAlign.center),
                              Text(" Doctors",style: TextStyle(fontSize: 11),textAlign: TextAlign.center),
                            ],
                          ))
                        ]),
                      ),
                     
                    ],
                  ),SizedBox(height: 20,),

                  //row 2

                   Row(                
                    //children: [ SizedBox(width: 15,) , Text("F&Q",style: TextStyle(color: const Color.fromARGB(255, 0, 50, 92)),)],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                     //book an appointment
                      Container(
                        alignment: Alignment.center,
                        height: 100,width: 100,
                        decoration:BoxDecoration(border: Border.all(color: Colors.blueGrey),borderRadius: BorderRadius.circular(20)) ,
                        child: Column(children: [
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => BookAppointment(),));
                          }, child: Column(
                            children: [
                              Icon(Icons.calendar_month_outlined,size: 50,),
                              Text("Book an appointment",style: TextStyle(fontSize: 11),textAlign: TextAlign.center),
                            ],
                          ))
                        ]),
                      ),
                      //my appointment
                      Container(
                        alignment: Alignment.center,
                        height: 100,width: 100,
                        decoration:BoxDecoration(border: Border.all(color: Colors.blueGrey),borderRadius: BorderRadius.circular(20)) ,
                        //color: Colors.red,
                        child: Column(children: [
                          // Icon(Icons.schedule),
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppointments(),));
                          }, child: Column(
                            children: [
                              Icon(Icons.schedule_rounded,size: 50,),
                              Text("My Appointments",style: TextStyle(fontSize: 11),textAlign: TextAlign.center),
                            ],
                          ))
                        ]),
                      ),
                      //our doctors
                      Container(
                        alignment: Alignment.center,
                        height: 100,width: 100,
                        decoration:BoxDecoration(border: Border.all(color: Colors.blueGrey),borderRadius: BorderRadius.circular(20)) ,
                        //color: Colors.red,
                        child: Column(children: [
                          // Icon(Icons.schedule),
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsPage(),));                          }, child: Column(
                            children: [
                              Icon(Icons.feedback_outlined,size: 50,),
                              Text("Feedback",style: TextStyle(fontSize: 11),textAlign: TextAlign.center),
                              //Text(" ",style: TextStyle(fontSize: 11),textAlign: TextAlign.center),
                            ],
                          ))
                        ]),
                      ),
                      //our hospitals
                      //SizedBox(width: 20,),
                      // Container(
                      //   alignment: Alignment.center,
                      //   height: 100,width: 100,
                      //   decoration:BoxDecoration(border: Border.all(color: Colors.blueGrey),borderRadius: BorderRadius.circular(20)) ,
                      //   //color: Colors.red,
                      //   child: Column(children: [
                      //     // Icon(Icons.schedule),
                      //     TextButton(onPressed: (){}, child: Column(
                      //       children: [
                      //         Icon(Icons.business,size: 50,),
                      //         Text("Our ",style: TextStyle(fontSize: 11),textAlign: TextAlign.center),
                      //         Text(" hospitals",style: TextStyle(fontSize: 11),textAlign: TextAlign.center),
                      //       ],
                      //     ))
                      //   ]),
                      // ),
                    ],
                  ),SizedBox(height: 20,),

                  //row 3

                   Row(                
                    //children: [ SizedBox(width: 15,) , Text("F&Q",style: TextStyle(color: const Color.fromARGB(255, 0, 50, 92)),)],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //my appointment
                      // Container(
                      //   alignment: Alignment.center,
                      //   height: 100,width: 100,
                      //   decoration:BoxDecoration(border: Border.all(color: Colors.blueGrey),borderRadius: BorderRadius.circular(20)) ,
                      //   //color: Colors.red,
                      //   child: Column(children: [
                      //     // Icon(Icons.schedule),
                      //     TextButton(onPressed: (){
                      //       Navigator.push(context, MaterialPageRoute(builder: (context) => MyAppointments(),));
                      //     }, child: Column(
                      //       children: [
                      //         Icon(Icons.schedule_rounded,size: 50,),
                      //         Text("My Appointments",style: TextStyle(fontSize: 11),textAlign: TextAlign.center),
                      //       ],
                      //     ))
                      //   ]),
                      // ),
                      //feedback
                      SizedBox(width: 20,),
                      Container(
                        alignment: Alignment.center,
                        height: 100,width: 100,
                        decoration:BoxDecoration(border: Border.all(color: Colors.blueGrey),borderRadius: BorderRadius.circular(20)) ,
                        //color: Colors.red,
                        child: Column(children: [
                          // Icon(Icons.schedule),
                          TextButton(onPressed: (){}, child: Column(
                            children: [
                              Icon(Icons.feedback_outlined,size: 50,),
                              Text("Feedback",style: TextStyle(fontSize: 11),textAlign: TextAlign.center),
                            ],
                          ))
                        ]),
                      ),SizedBox(width: 15,),
                      //our doctors
                      Container(
                        alignment: Alignment.center,
                        height: 100,width: 100,
                        decoration:BoxDecoration(border: Border.all(color: Colors.blueGrey),borderRadius: BorderRadius.circular(20)) ,
                        //color: Colors.red,
                        child: Column(children: [
                          // Icon(Icons.schedule),
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsPage(),));                          }, child: Column(
                            children: [
                              Icon(Icons.info_outline,size: 50,),
                              Text("About ",style: TextStyle(fontSize: 11),textAlign: TextAlign.center),
                              Text(" Us",style: TextStyle(fontSize: 11),textAlign: TextAlign.center),
                            ],
                          ))
                        ]),
                      ),
                      //our hospitals
                      //SizedBox(width: 20,),
                      // Container(
                      //   alignment: Alignment.center,
                      //   height: 100,width: 100,
                      //   decoration:BoxDecoration(border: Border.all(color: Colors.blueGrey),borderRadius: BorderRadius.circular(20)) ,
                      //   //color: Colors.red,
                      //   child: Column(children: [
                      //     // Icon(Icons.schedule),
                      //     TextButton(onPressed: (){}, child: Column(
                      //       children: [
                      //         Icon(Icons.business,size: 50,),
                      //         Text("Our ",style: TextStyle(fontSize: 11),textAlign: TextAlign.center),
                      //         Text(" hospitals",style: TextStyle(fontSize: 11),textAlign: TextAlign.center),
                      //       ],
                      //     ))
                      //   ]),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          ],
        ),
      ),

        //floating action button to dialer
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        //mini: true,
        backgroundColor: Colors.red[400],
        onPressed: () {
          _launchDialer('123456789'); // Replace '123456789' with the specific number
        },
        child: Icon(Icons.local_hospital, color: Colors.white), // Use the ambulance icon
      ),

    );
  }

    //launch dialer
  void _launchDialer(String phoneNumber) async{
           Uri phoneno = Uri.parse('tel:108000');
       if (await launchUrl(phoneno)) {
              //dialer opened
          }else{
          SnackBar(content: Text("couldn't launch dialer"));
      }
    } 

}