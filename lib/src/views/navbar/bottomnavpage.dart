import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';
import 'package:todo_app/src/models/taskmodel.dart';
import 'package:todo_app/src/services/taskservice.dart';
import 'package:todo_app/src/views/calenderpage.dart';
import 'package:todo_app/src/views/focusepage.dart';
import 'package:todo_app/src/views/homepage.dart';
import 'package:todo_app/src/views/profilepage.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({super.key});

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}


int priority = 0;
String category = "";
String cateColor = "";
String cateImg = "";

class _BottomNavPageState extends State<BottomNavPage> {
  @override
  void initState() {
    // TODO: implement initState
    priority = 0;
    category = "";
    cateImg = "";
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    priority;
    category;
    cateImg;
    super.dispose();
  }

  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const CalenderPage(),
    const FocusePage(),
    const ProfilePage(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();

  Widget currentScreen = HomePage();

  final TextEditingController _taskController = TextEditingController();

  void _createTask()async{
    try{
      final user = FirebaseAuth.instance.currentUser;
      await TaskService().saveTask(TaskModel(
          taskId: '',
          name: _taskController.text,
          priority: priority,
          category: category,
          color: cateColor,
          userId: user!.uid,
          cateImg: cateImg));
    }catch(error){
      print("Error : $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //bottom Navigation bar with fab
      //bottom navigation bar

      bottomNavigationBar: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  //Home button

                  MaterialButton(
                    minWidth: 30.w,
                    onPressed: (){
                      setState(() {
                        _currentIndex == 0;
                        currentScreen = const HomePage();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.home,color: _currentIndex == 0 ? Colors.white :const Color.fromRGBO(255, 255, 255, 0.98),),
                        Text("Home",style: TextStyle(
                          color: _currentIndex == 0 ? Colors.white :const Color.fromRGBO(255, 255, 255, 0.98)
                        ),)
                      ],
                    ),
                  ),

                  //Calender button

                  MaterialButton(
                    minWidth: 30.w,
                    onPressed: (){
                      setState(() {
                        _currentIndex == 1;
                        currentScreen = const CalenderPage();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.calendar_month_outlined,color: _currentIndex == 1 ? Colors.white :const Color.fromRGBO(255, 255, 255, 0.98)),
                        Text("Calender",style: TextStyle(
                            color: _currentIndex == 1 ? Colors.white :const Color.fromRGBO(255, 255, 255, 0.98)
                        ),)
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  //Focuse button

                  MaterialButton(
                    minWidth: 30.w,
                    onPressed: (){
                      setState(() {
                        _currentIndex == 2;
                        currentScreen = const FocusePage();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.access_time,color: _currentIndex == 2 ? Colors.white :const Color.fromRGBO(255, 255, 255, 0.98)),
                        Text("Focuse",style: TextStyle(
                            color: _currentIndex == 2 ? Colors.white :const Color.fromRGBO(255, 255, 255, 0.98)
                        ),)
                      ],
                    ),
                  ),
                  // SizedBox(width: 40.w,),

                  //Profile button

                  MaterialButton(
                    minWidth: 30.w,
                    onPressed: (){
                      setState(() {
                        _currentIndex == 3;
                        currentScreen = const ProfilePage();
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(Icons.person_outline,color: _currentIndex == 3 ? Colors.white :const Color.fromRGBO(255, 255, 255, 0.98)),
                        Text("Profile",style: TextStyle(
                            color: _currentIndex == 3 ? Colors.white :const Color.fromRGBO(255, 255, 255, 0.98)
                        ),)
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),

      //fsb

      floatingActionButton: FloatingActionButton(
        shape:const CircleBorder(),
        backgroundColor:const Color.fromRGBO(134, 135, 231, 1),
        onPressed: (){

          //bottom sheet for adding tasks

          showModalBottomSheet(context: context, builder: (context) {
            return SizedBox(
              height: MediaQuery.of(context).size.height/2,
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    //title

                    Text("Add Task",style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color:const Color.fromRGBO(255, 255, 255, 0.87)
                    ),),
                    SizedBox(height: 10.h,),
                    TextFormField(
                      controller: _taskController,
                      decoration: InputDecoration(
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

                              //time adding button
                              IconButton(onPressed: (){}, icon: const Icon(Icons.timer_outlined)),

                              //category adding button
                              IconButton(onPressed: (){

                                //Dialog box for choosing a category
                                showDialog(context: context, builder: (context) {
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

                              //priority adding button
                              IconButton(onPressed: (){

                                //Dialog box for choosing priority
                                showDialog(context: context, builder: (context) {
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

                            //task saving button
                            IconButton(onPressed: (){
                              _createTask();
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
        child:const Icon(Icons.add),),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PageStorage(bucket: bucket, child: currentScreen,)
    );
  }
}
