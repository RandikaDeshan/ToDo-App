

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/src/models/taskmodel.dart';
import 'package:todo_app/src/services/authservice.dart';
import 'package:todo_app/src/services/taskservice.dart';
import 'package:todo_app/src/views/edittask.dart';

import 'navbar/bottomnavpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

int priority = 0;
String category = "";
String cateColor = "";
String cateImg = "";
String name = "";

String username ="";
String image = '';

class _HomePageState extends State<HomePage> {

  @override
  void initState() {

    AuthService().getUserDetails(user!.uid).then((value){
      if(value![0] != ''){
        setState(() {
          username = value[0];
          image = value[1];
        });
      }
    });
    // TODO: implement initState
    priority = 0;
    category = "";
    cateImg = "";
    name = "";
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    priority;
    category;
    cateImg;
    name;
    super.dispose();
  }

  //get the current user
  final user = FirebaseAuth.instance.currentUser;

  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //appbar

      appBar: AppBar(
        leading:const Icon(Icons.menu),
        title: Text(username),
        centerTitle: true,
        actions: [
          image.contains("http")?Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: CircleAvatar(
              backgroundImage: NetworkImage(image),
              backgroundColor: Colors.transparent,
            ),
          ):Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: CircleAvatar(
              backgroundImage:image != ""? FileImage(File(image)):const AssetImage("assets/images/profile.png"),
              backgroundColor: Colors.transparent,
            ),
          ),

        ],
      ),


      body: FutureBuilder(future: TaskService().getUserTasks(user!.uid), builder: (context, snapshot) {

        //waiting for data
        if(snapshot.connectionState == ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator());
        }

        //screen for empty data(tasks)
        else if(!snapshot.hasData || snapshot.data!.isEmpty){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Center(child: Image(image: AssetImage("assets/images/Checklist-rafiki.png"),)),
              Text("What do you want to do today?",style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                  color:const Color.fromRGBO(255, 255, 255, 0.87)
              ),),
              SizedBox(height: 20.h,),
              Text("Tap + to add your tasks",style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color:const Color.fromRGBO(255, 255, 255, 0.87)
              ),),
            ],
          );
        }

        //tasks screen
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Column(
            children: [

              //search box

              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color:const Color.fromRGBO(151, 151, 151, 1),
                    width: 0.8
                  ),
                  borderRadius: BorderRadius.circular(4)
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    icon: IconButton(onPressed: (){}, icon:const Icon(Icons.search)),
                    hintText: "Search for your task...",
                    hintStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color:const Color.fromRGBO(175, 175, 175, 1)
                    ),
                  ),
                ),
              ),


              SizedBox(height: 20.h,),


              Expanded(
                child: ListView.builder(itemCount: snapshot.data!.length,itemBuilder: (context, index) {
                  TaskModel task = snapshot.data![index];

                  //task card

                  return GestureDetector(

                    //when long press the card open a page to edit task
                    onLongPress: () {
                      showDialog(context: context, builder: (context) {
                        return EditTaskPage(id: task.taskId);
                      },useSafeArea: true);
                    },
                    onTap: () {

                      //when tap on the card display bottom sheet to edit task
                      //bottom sheet
                      showModalBottomSheet(context: context, builder: (context) {
                        return SizedBox(
                          height: MediaQuery.of(context).size.height/2,
                          width: MediaQuery.of(context).size.width,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Add Task",style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color:const Color.fromRGBO(255, 255, 255, 0.87)
                                ),),
                                SizedBox(height: 10.h,),
                                Text(task.name,style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w400,
                                    color:const Color.fromRGBO(255, 255, 255, 0.87)
                                ),),
                                SizedBox(height: 10.h,),
                                TextFormField(
                                  controller: _taskController,
                                  decoration: InputDecoration(
                                    hintText: task.name,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(4),
                                          borderSide:const BorderSide(
                                              color: Color.fromRGBO(151, 151, 151, 1),
                                              width: 1
                                          )
                                      )
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(onPressed: (){}, icon: const Icon(Icons.timer_outlined)),

                                        //add category button
                                        IconButton(onPressed: (){
                                          showDialog(context: context, builder: (context) {

                                            //dialog box for adding category
                                            return Dialog(
                                              child: SizedBox(
                                                height: 550.h,
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text("Choose Category",style: TextStyle(
                                                          fontSize: 18.sp,
                                                          fontWeight: FontWeight.w700,
                                                          color:const Color.fromRGBO(255, 255, 255, 0.87)
                                                      ),),
                                                    ),
                                                    const Padding(
                                                      padding: EdgeInsets.all(8.0),
                                                      child: Divider(
                                                        color: Color.fromRGBO(151, 151, 151, 1),
                                                        height: 1,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(vertical: 5.h),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                category = "Grocery";
                                                                cateImg = "assets/images/Vector1.png";
                                                                cateColor = "0xffCCFF80";
                                                              });
                                                            },
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  height: 64.h,
                                                                  width: 64.w,
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.circular(4),
                                                                    color:const Color(0xffCCFF80),
                                                                  ),
                                                                  child:const Image(image: AssetImage("assets/images/Vector1.png")),
                                                                ),
                                                                SizedBox(height: 5.h,),
                                                                Text("Grocery",style: TextStyle(
                                                                    fontSize: 14.sp,
                                                                    fontWeight: FontWeight.w500,
                                                                    color:const Color.fromRGBO(255, 255, 255, 0.87)
                                                                ),)
                                                              ],
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                category = "Work";
                                                                cateImg = "assets/images/Vector2.png";
                                                                cateColor = "0xffFF9680";
                                                              });
                                                            },
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  height: 64.h,
                                                                  width: 64.w,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(4),
                                                                      color:const Color(0xffFF9680),
                                                                  ),
                                                                  child:const Image(image: AssetImage("assets/images/Vector2.png")),
                                                                ),
                                                                SizedBox(height: 5.h,),
                                                                Text("Work",style: TextStyle(
                                                                    fontSize: 14.sp,
                                                                    fontWeight: FontWeight.w500,
                                                                    color:const Color.fromRGBO(255, 255, 255, 0.87)
                                                                ),)
                                                              ],
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                category = "Sport";
                                                                cateImg = "assets/images/Group.png";
                                                                cateColor = "0xff80FFFF";
                                                              });
                                                            },
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  height: 64.h,
                                                                  width: 64.w,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(4),
                                                                      color:const Color(0xff80FFFF),
                                                                  ),
                                                                  child:const Image(image: AssetImage("assets/images/Group.png")),
                                                                ),
                                                                SizedBox(height: 5.h,),
                                                                Text("Sport",style: TextStyle(
                                                                    fontSize: 14.sp,
                                                                    fontWeight: FontWeight.w500,
                                                                    color:const Color.fromRGBO(255, 255, 255, 0.87)
                                                                ),)
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(vertical: 5.h),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                category = "Design";
                                                                cateImg = "assets/images/design (1) 1.png";
                                                                cateColor = "0xff80FFD9";
                                                              });
                                                            },
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  height: 64.h,
                                                                  width: 64.w,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(4),
                                                                      color:const Color(0xff80FFD9),
                                                                  ),
                                                                  child:const Image(image: AssetImage("assets/images/design (1) 1.png")),
                                                                ),
                                                                SizedBox(height: 5.h,),
                                                                Text("Design",style: TextStyle(
                                                                    fontSize: 14.sp,
                                                                    fontWeight: FontWeight.w500,
                                                                    color:const Color.fromRGBO(255, 255, 255, 0.87)
                                                                ),)
                                                              ],
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                category = "University";
                                                                cateImg = "assets/images/Vector3.png";
                                                                cateColor = "0xff809CFF";
                                                              });
                                                            },
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  height: 64.h,
                                                                  width: 64.w,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(4),
                                                                      color:const Color(0xff809CFF),
                                                                  ),
                                                                  child:const Image(image: AssetImage("assets/images/Vector3.png")),
                                                                ),
                                                                SizedBox(height: 5.h,),
                                                                Text("University",style: TextStyle(
                                                                    fontSize: 14.sp,
                                                                    fontWeight: FontWeight.w500,
                                                                    color:const Color.fromRGBO(255, 255, 255, 0.87)
                                                                ),)
                                                              ],
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                category = "Social";
                                                                cateImg = "assets/images/megaphone 1.png";
                                                                cateColor = "0xffFF80EB";
                                                              });
                                                            },
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  height: 64.h,
                                                                  width: 64.w,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(4),
                                                                      color:const Color(0xffFF80EB),
                                                                  ),
                                                                  child:const Image(image: AssetImage("assets/images/megaphone 1.png")),
                                                                ),
                                                                SizedBox(height: 5.h,),
                                                                Text("Social",style: TextStyle(
                                                                    fontSize: 14.sp,
                                                                    fontWeight: FontWeight.w500,
                                                                    color:const Color.fromRGBO(255, 255, 255, 0.87)
                                                                ),)
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(vertical: 5.h),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                category = "Music";
                                                                cateImg = "assets/images/Vector4.png";
                                                                cateColor = "0xffFC80FF";
                                                              });
                                                            },
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  height: 64.h,
                                                                  width: 64.w,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(4),
                                                                      color:const Color(0xffFC80FF),
                                                                  ),
                                                                  child:const Image(image: AssetImage("assets/images/Vector4.png")),
                                                                ),
                                                                SizedBox(height: 5.h,),
                                                                Text("Music",style: TextStyle(
                                                                    fontSize: 14.sp,
                                                                    fontWeight: FontWeight.w500,
                                                                    color:const Color.fromRGBO(255, 255, 255, 0.87)
                                                                ),)
                                                              ],
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                category = "Health";
                                                                cateImg = "assets/images/Vector5.png";
                                                                cateColor = "0xff80FFA3";
                                                              });
                                                            },
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  height: 64.h,
                                                                  width: 64.w,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(4),
                                                                      color:const Color(0xff80FFA3),
                                                                  ),
                                                                  child:const Image(image: AssetImage("assets/images/Vector5.png")),
                                                                ),
                                                                SizedBox(height: 5.h,),
                                                                Text("Health",style: TextStyle(
                                                                    fontSize: 14.sp,
                                                                    fontWeight: FontWeight.w500,
                                                                    color:const Color.fromRGBO(255, 255, 255, 0.87)
                                                                ),)
                                                              ],
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                category = "Movie";
                                                                cateImg = "assets/images/Vector6.png";
                                                                cateColor = "0xff80D1FF";
                                                              });
                                                            },
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  height: 64.h,
                                                                  width: 64.w,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(4),
                                                                      color:const Color(0xff80D1FF),
                                                                  ),
                                                                  child:const Image(image: AssetImage("assets/images/Vector6.png")),
                                                                ),
                                                                SizedBox(height: 5.h,),
                                                                Text("Movie",style: TextStyle(
                                                                    fontSize: 14.sp,
                                                                    fontWeight: FontWeight.w500,
                                                                    color:const Color.fromRGBO(255, 255, 255, 0.87)
                                                                ),)
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(vertical: 5.h),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                category = "Home";
                                                                cateImg = "assets/images/Vector7.png";
                                                                cateColor ="0xffFFCC80";
                                                              });
                                                            },
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  height: 64.h,
                                                                  width: 64.w,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(4),
                                                                      color:const Color(0xffFFCC80),
                                                                  ),
                                                                  child:const Image(image: AssetImage("assets/images/Vector7.png")),
                                                                ),
                                                                SizedBox(height: 5.h,),
                                                                Text("Home",style: TextStyle(
                                                                    fontSize: 14.sp,
                                                                    fontWeight: FontWeight.w500,
                                                                    color:const Color.fromRGBO(255, 255, 255, 0.87)
                                                                ),)
                                                              ],
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              setState(() {
                                                                category = "Create New";
                                                                cateImg = "assets/images/Vector8.png";
                                                                cateColor ="0xff80FFD1";
                                                              });
                                                            },
                                                            child: Column(
                                                              children: [
                                                                Container(
                                                                  height: 64.h,
                                                                  width: 64.w,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(4),
                                                                      color:const Color(0xff80FFD1),
                                                                  ),
                                                                  child:const Image(image: AssetImage("assets/images/Vector8.png")),
                                                                ),
                                                                SizedBox(height: 5.h,),
                                                                Text("Create New",style: TextStyle(
                                                                    fontSize: 14.sp,
                                                                    fontWeight: FontWeight.w500,
                                                                    color:const Color.fromRGBO(255, 255, 255, 0.87)
                                                                ),)
                                                              ],
                                                            ),
                                                          ),
                                                          Column(
                                                            children: [
                                                              Container(
                                                                height: 64.h,
                                                                width: 64.w,

                                                              ),

                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.symmetric(vertical: 8.h),
                                                      child: TextButton(onPressed: (){
                                                        Navigator.pop(context);
                                                      },
                                                          style: TextButton.styleFrom(
                                                            backgroundColor:const Color.fromRGBO(134, 135, 231, 1),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(4)
                                                            ),
                                                            fixedSize: Size.fromWidth(289.w)
                                                          )
                                                          ,child: Text("Add Category",style: TextStyle(
                                                            fontSize: 16.sp,
                                                            fontWeight: FontWeight.w400,
                                                            color: Colors.white
                                                          ),)),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },);
                                        }, icon:const Icon(Icons.label_outline,)),

                                        //add priority button
                                        IconButton(onPressed: (){
                                          showDialog(context: context, builder: (context) {

                                            //dialog box for adding priority
                                            return Dialog(
                                              child: SizedBox(
                                                height: 420.h,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      Text("Task Priority",style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight: FontWeight.w700,
                                                          color:const Color.fromRGBO(255, 255, 255, 0.87)
                                                      ),),
                                                      const Divider(color: Color.fromRGBO(151, 151, 151, 1),),
                                                      Padding(
                                                        padding: EdgeInsets.symmetric(vertical: 10.h),
                                                        child: GroupButton(buttons: const[
                                                          "1",
                                                          "2",
                                                          "3",
                                                          "4",
                                                          "5",
                                                          "6",
                                                          "7",
                                                          "8",
                                                          "9",
                                                          "10",
                                                        ],isRadio: true,maxSelected: 1,options: GroupButtonOptions(
                                                          buttonWidth: 64.w,
                                                          buttonHeight: 64.h,
                                                          groupingType: GroupingType.wrap,
                                                          direction: Axis.horizontal,
                                                          mainGroupAlignment: MainGroupAlignment.start,
                                                          selectedTextStyle: const TextStyle(
                                                            color: Colors.white
                                                          ),
                                                          unselectedTextStyle: const TextStyle(
                                                            color: Colors.white
                                                          ),
                                                          selectedColor:const Color.fromRGBO(134, 135, 231, 1),
                                                          unselectedColor:const Color.fromRGBO(39, 39, 39, 1),
                                                        ),onSelected: (value, index, isSelected) {
                                                          setState(() {
                                                            priority = index+1;                                                          });
                                                        },),
                                                      ),
                                                      Row(
                                                        children: [
                                                          TextButton(onPressed: (){
                                                            setState(() {
                                                              priority = 0;
                                                            });
                                                            Navigator.pop(context);
                                                          },style: TextButton.styleFrom(
                                                            fixedSize: Size.fromWidth(143.w)
                                                          ),
                                                          child: Text("Cancel",style: TextStyle(
                                                              fontSize: 16.sp,
                                                              fontWeight: FontWeight.w400,
                                                              color:const Color.fromRGBO(134, 135, 231, 1)
                                                          ),)),
                                                          TextButton(onPressed: (){
                                                            print("$priority");
                                                            Navigator.pop(context);
                                                          },style: TextButton.styleFrom(
                                                              fixedSize: Size.fromWidth(130.w),
                                                            backgroundColor:const Color.fromRGBO(134, 135, 231, 1),
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius: BorderRadius.circular(4)
                                                            )
                                                          ),
                                                              child: Text("Save",style: TextStyle(
                                                                  fontSize: 16.sp,
                                                                  fontWeight: FontWeight.w400,
                                                                  color:Colors.white
                                                              ),)),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },);
                                        }, icon:const Icon(Icons.flag_outlined)),
                                      ],
                                    ),
                                    Row(
                                      children: [

                                        //update task button
                                        IconButton(onPressed: ()async{
                                          if(_taskController.text == ""){
                                            name = task.name;
                                          }else{
                                            name = _taskController.text;
                                          }
                                          if(priority == 0){
                                            priority = task.priority;
                                          }
                                          if(category == ""){
                                            category = task.category;
                                          }
                                          if(cateColor == ""){
                                            cateColor = task.color;
                                          }
                                          if(cateImg == ""){
                                            cateImg = task.cateImg;
                                          }
                                          await TaskService().updateTask(
                                            TaskModel(
                                                taskId: task.taskId,
                                                name: name,
                                                priority: priority,
                                                category: category,
                                                color: cateColor,
                                                userId: task.userId,
                                                createdAt: task.createdAt,
                                                cateImg: cateImg)
                                          );
                                          Navigator.push(context, MaterialPageRoute(builder: (context) {
                                            return const BottomNavPage();
                                          },));
                                        }, icon:const Icon(Icons.send)),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },);
                    },
                    child: Card(
                      child: Column(
                        children: [
                          ListTile(

                            //title of task
                            title: Text(task.name),

                            //task created date and time
                            subtitle: Text(DateFormat("EEEE At H.m").format(task.createdAt!)),
                            leading: CircleAvatar(radius: 8,
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
                          ),

                          //if there is a category or priority, display this row
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              task.category != "" ?
                              Padding(
                                padding: EdgeInsets.only(bottom: 5.h,left: 5.w,right: 5.w),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Color(int.parse(task.color))
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Image(image: AssetImage(task.cateImg),height: 14.h,width: 14.w,),
                                        SizedBox(width: 5.w,),
                                        Text(task.category,style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.white
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ): SizedBox(
                                width: 5.w,
                              ),
                              task.priority != 0 ?
                              Padding(
                                padding:EdgeInsets.only(bottom: 5.h,left: 5.w,right: 10.w),
                                child: Container(
                                  decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border: Border.all(
                                    color:const Color.fromRGBO(134, 135, 231, 1),
                                    width: 1
                                  )
                                ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        const Icon(Icons.flag_outlined,size:14,),
                                        SizedBox(width: 5.w,),
                                        Text(task.priority.toString(),style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            color:const Color.fromRGBO(232, 232, 232, 1)
                                        ),)
                                      ],
                                    ),
                                  ),
                                ),
                              ):SizedBox(
                                width: 5.w,
                              )
                            ],
                          )
                        ],
                      ),
                      
                    ),
                  );
                },),
              )
            ],
          ),
        );
      },)

    );
  }
}
