import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/src/models/taskmodel.dart';
import 'package:todo_app/src/services/taskservice.dart';
import 'package:todo_app/src/views/navbar/bottomnavpage.dart';

class EditTaskPage extends StatefulWidget {
  final String id;
  const EditTaskPage({super.key, required this.id});

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: TaskService().getById(widget.id),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          if(!snapshot.hasData){
            return const Center(
              child: Text("No Data"),
            );
          }
          TaskModel task = snapshot.data!;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        //exit button
                        IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                            return const BottomNavPage();
                          },));
                        }, icon:const Icon(Icons.close),
                          style: IconButton.styleFrom(
                              backgroundColor:const Color.fromRGBO(29, 29, 29, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)
                              )
                          ),
                        ),

                        //repeat button
                        IconButton(onPressed: (){},
                          icon:const Icon(Icons.repeat),
                          style: IconButton.styleFrom(
                              backgroundColor:const Color.fromRGBO(29, 29, 29, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)
                              )
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding:EdgeInsets.only(top: 40.h,bottom: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(radius: 8,
                            backgroundColor: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 1.5,
                                      color:const Color.fromRGBO(255, 255, 255, 0.87)
                                  ),
                                  borderRadius: BorderRadius.circular(8)
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(task.name,style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w400,
                                  color:const Color.fromRGBO(255, 255, 255, 0.87)
                              ),),
                              Text(DateFormat("MMM d EEEE At H.m").format(task.createdAt!),style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color:const Color.fromRGBO(175, 175, 175, 1)
                              ),),
                            ],
                          ),
                          const Icon(Icons.edit),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.timer_outlined),
                              SizedBox(width: 10.w,),
                              Text("Task Time :",style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color:const Color.fromRGBO(255, 255, 255, 0.87)
                              ),)
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color:const Color.fromRGBO(255, 255, 255, 0.21),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(DateFormat("EEEE At H.m").format(task.createdAt!),style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color:const Color.fromRGBO(255, 255, 255, 0.87)
                              ),),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.label_outline),
                              SizedBox(width: 10.w,),
                              Text("Task Category :",style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color:const Color.fromRGBO(255, 255, 255, 0.87)
                              ),)
                            ],
                          ),
                          task.category != ""?Container(
                            decoration: BoxDecoration(
                              color:const Color.fromRGBO(255, 255, 255, 0.21),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Image(image: AssetImage(task.cateImg),height: 24.h,width: 24.w,),
                                  SizedBox(width: 5.w,),
                                  Text(task.category,style: TextStyle(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      color:const Color.fromRGBO(255, 255, 255, 0.87)
                                  ),),
                                ],
                              ),
                            ),
                          ):Container(
                            decoration: BoxDecoration(
                              color:const Color.fromRGBO(255, 255, 255, 0.21),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Default",style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color:const Color.fromRGBO(255, 255, 255, 0.87)
                              ),),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding:EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.flag_outlined),
                              SizedBox(width: 10.w,),
                              Text("Task Priority :",style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color:const Color.fromRGBO(255, 255, 255, 0.87)
                              ),)
                            ],
                          ),
                          task.priority >0 ?Container(
                            decoration: BoxDecoration(
                              color:const Color.fromRGBO(255, 255, 255, 0.21),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(task.priority.toString(),style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color:const Color.fromRGBO(255, 255, 255, 0.87)
                              ),),
                            ),
                          ):Container(
                            decoration: BoxDecoration(
                              color:const Color.fromRGBO(255, 255, 255, 0.21),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Default",style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color:const Color.fromRGBO(255, 255, 255, 0.87)
                              ),),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.share),
                              SizedBox(width: 10.w,),
                              Text("Sub - Task",style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color:const Color.fromRGBO(255, 255, 255, 0.87)
                              ),)
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color:const Color.fromRGBO(255, 255, 255, 0.21),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Add Sub - Task",style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color:const Color.fromRGBO(255, 255, 255, 0.87)
                              ),),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: GestureDetector(
                        onTap: () {
                          showDialog(context: context, builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                              child: SizedBox(
                                height: 100.h,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text("Are you sure?",style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          color:const Color.fromRGBO(255, 255, 255, 0.87)
                                      ),),
                                      const Divider(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          TextButton(onPressed: (){
                                            Navigator.pop(context);
                                          },
                                              style: TextButton.styleFrom(
                                                fixedSize: Size.fromWidth(100.w),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4),
                                                side: const BorderSide(color: Color.fromRGBO(255, 255, 255, 0.6)))
                                              ),
                                              child: Text("Cancel",style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color:const Color.fromRGBO(255, 255, 255, 0.87)
                                              ))),
                                          TextButton(onPressed: ()async{
                                            await TaskService().deleteTask(task.taskId);
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                              return const BottomNavPage();
                                            },));
                                          },
                                              style: TextButton.styleFrom(
                                                backgroundColor: const Color.fromRGBO(134, 135, 231, 1),
                                                  fixedSize: Size.fromWidth(100.w),
                                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4),
                                                      )
                                              ),
                                              child: Text("Delete",style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                              color:const Color.fromRGBO(255, 255, 255, 0.87)
                                          ))),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },);
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.delete_outline,color: const Color.fromRGBO(255, 73, 73, 1),),
                            SizedBox(width: 10.w,),
                            Text("Delete Task",style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w400,
                                color:const Color.fromRGBO(255, 73, 73, 1)
                            ),),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Column(
                children: [
                  TextButton(onPressed: (){},
                      style: TextButton.styleFrom(
                          backgroundColor:const Color.fromRGBO(134, 135, 231, 1),
                          fixedSize: Size.fromWidth(327.w),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)
                          )
                      ),
                      child: Text("Edit Task",style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color:const Color.fromRGBO(255, 255, 255, 1)
                      ),)),
                  SizedBox(height: 20.h,)
                ],
              )

            ],
          );
        },

      ),
    );
  }
}
