import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:medilink/admin/db/appointment_functions.dart';
import 'package:medilink/admin/model/appointment_model.dart';
import 'package:url_launcher/url_launcher.dart';

class AppointmentViewPage extends StatefulWidget {
  const AppointmentViewPage({super.key});

  @override
  State<AppointmentViewPage> createState() => _AppointmentViewPageState();
}

class _AppointmentViewPageState extends State<AppointmentViewPage> {
  @override
  Widget build(BuildContext context) {
    getAppointment();
    return Scaffold(

      appBar: AppBar(
        title: Text("appointments"),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                    height: 500,
                    child: ValueListenableBuilder(
                      valueListenable: appointmentListNotifier,
                      builder: (BuildContext ctx, List<AppointmentModel> appointmentList,Widget? child) {
                        
                      
                      return ListView.separated(
                      itemBuilder:((context, index) {
                        final data=appointmentList[index];
      
                        return Slidable(
                          //delete button
                                endActionPane: ActionPane(
                                  motion:const DrawerMotion() ,
                               children: [
                                //delete
                                SlidableAction(onPressed: (context) {
                                     // deleteTelemedicine(data.id!);
                                   },
           
                                icon:Icons.delete,
                                backgroundColor: const Color.fromARGB(255, 248, 3, 3),
                                ),
                               ] ),
                          //call buton
                               startActionPane: ActionPane(
                                  motion:const DrawerMotion() ,
                               children: [
                                //delete
                                SlidableAction(onPressed: (context) {
                                      _launchDialer(data.mobile);
                                   },
           
                                icon:Icons.call,foregroundColor: Colors.white,
                                backgroundColor: Color.fromARGB(206, 90, 214, 19),
                                ),
                               ] ),
                             
                                        
          
                          child: Container(
                            child: ListTile(
                              horizontalTitleGap: 20,
                              contentPadding: EdgeInsets.all(5),
                              leading: Text("   ${index+1}"),
                              title: InkWell
                              (onTap: () { },
                              child:
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('${data.title} ${data.name} '),
                                  Text("Email : ${data.email}, Mob:${data.mobile}"),
                                  Text("${data.gender} / ${data.marital}")
                                ],
                              )),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 5,),
                                  Text('Gender: ${data.dob}'),
                                  Text('Symptoms: ${data.address}'),
                                  //Text('Address: ${data.address}'),
                                  //Text('Mobile: ${data.mobile}'), 
                                ],
                              ),  
                              // trailing:IconButton(onPressed: (){
                              //   // _launchDialer(data.mobile);
                              //  }, icon: Icon(Icons.call))                  
                            ),
                          ),
                          
                        );
                      }) , 
                     separatorBuilder: ((context, index) {
                      return const Divider();
                      }), 
                    itemCount:appointmentList.length);
                   }, ),
                  ),
          ],
      
        ),
      ),
    );
  }
      //launch dialer
 void _launchDialer(String phoneNumber) async{

           Uri phoneno = Uri.parse('tel:+91$phoneNumber');
       if (await launchUrl(phoneno)) {
              //dialer opened
          }else{
          SnackBar(content: Text("couldn't launch dialer"));
      }
    } 
}