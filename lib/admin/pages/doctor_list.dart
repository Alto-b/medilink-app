import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:medilink/admin/db/doctor_functions.dart';
import 'package:medilink/admin/model/doctor_model.dart';

class DoctorListPage extends StatefulWidget {
  const DoctorListPage({super.key});

  @override
  State<DoctorListPage> createState() => _DoctorListPageState();
}

class _DoctorListPageState extends State<DoctorListPage> {

  @override
  void initState(){
    super.initState();
     getDoctor();
  }



  @override
  Widget build(BuildContext context) {

   

    return Scaffold(

      appBar: AppBar(
        title: Text("DOCTOR LIST"),
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text("list of doctors"),
        //listener
                  SizedBox(
                      height: 500,
                      child: ValueListenableBuilder(
                        valueListenable: doctorListNotifier,
                        builder: (BuildContext ctx, List<DoctorModel> doctorList,Widget? child) {
        
                        return ListView.separated(
                        itemBuilder:((context, index) {
                          final data=doctorList[index];
        
                          return Slidable(
                                  endActionPane: ActionPane(
                                    motion:DrawerMotion() ,
                                 children: [
                                  //delete
                                  SlidableAction(onPressed: (context) {
                                    // deleteDept(data.id!);
                                    // _departmentController.clear();
                                  },
                                  icon:Icons.delete,
                                  backgroundColor: Color.fromARGB(255, 248, 3, 3),
                                  ),
                                 ] ),
                               
                                          
            
                            child: Container(
                              child: ListTile(
                                horizontalTitleGap: 20,
                                contentPadding: EdgeInsets.all(5),
                                leading: Text("${index+1}"),
                                title: Text(data.name),                          
                              ),
                            ),
                            
                          );
                        }) , 
                       separatorBuilder: ((context, index) {
                        return const Divider();
                        }), 
                      itemCount:doctorList.length);
                     }, ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}