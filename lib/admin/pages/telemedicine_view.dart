import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:medilink/admin/db/telemedicine_functions.dart';
import 'package:medilink/admin/model/telemedicine_model.dart';

class TelemedicineViewPage extends StatefulWidget {
  const TelemedicineViewPage({super.key});

  @override
  State<TelemedicineViewPage> createState() => _TelemedicineViewPageState();
}

class _TelemedicineViewPageState extends State<TelemedicineViewPage> {
  @override
  Widget build(BuildContext context) {

    getTelemedicine();

    return Scaffold(

      appBar: AppBar(
        title: Text("Telemedicine portal"),
      ),

      //body
      body: Column(
        children: [
          SizedBox(
                  height: 500,
                  child: ValueListenableBuilder(
                    valueListenable: telemedicineListNotifier,
                    builder: (BuildContext ctx, List<TelemedicineModel> feedbackList,Widget? child) {
                      
                    
                    return ListView.separated(
                    itemBuilder:((context, index) {
                      final data=feedbackList[index];

                      return Slidable(
                        //delete button
                              endActionPane: ActionPane(
                                motion:const DrawerMotion() ,
                             children: [
                              //delete
                              SlidableAction(onPressed: (context) {
                                    deleteTelemedicine(data.id!);
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
                                    //deleteFeedbacks(data.id!);
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
                                Text('Name: ${data.name} '),
                                Text("Email : ${data.email}',")
                              ],
                            )),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5,),
                                Text('Medicine: ${data.medicine}'),
                                Text('Symptoms: ${data.symptoms}'),
                                Text('Address: ${data.address}'),
                                Text('Symptoms: ${data.symptoms}'),
                                
                                
                              ],
                            ),  
                            //trailing:IconButton(onPressed: (){ }, icon: Icon(Icons.call))                  
                          ),
                        ),
                        
                      );
                    }) , 
                   separatorBuilder: ((context, index) {
                    return const Divider();
                    }), 
                  itemCount:feedbackList.length);
                 }, ),
                ),
        ],

      ),
    );
  }
}