import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/src/views/intropage.dart';
import '../startpage.dart';

class FirstOnBoading extends StatefulWidget {
  const FirstOnBoading({super.key});

  @override
  State<FirstOnBoading> createState() => _FirstOnBoadingState();
}

class _FirstOnBoadingState extends State<FirstOnBoading> {
  int number = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        //Skip button
        //navigate to start screen

        title: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const StartPage();
            },));
          },
          child: Text("Skip",style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color:const Color.fromRGBO(255, 255, 255, 0.44)
          ),),
        ),
      ),



      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
                Image(image:number == 1? const AssetImage("assets/images/Group 182.png"): number == 2 ? const AssetImage("assets/images/Group 183.png"): const AssetImage("assets/images/Frame 161.png")),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 25.w),
                  child: Column(
                    children: [
                      number == 1 ?Text("Manage your tasks",style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w700,
                          color:const Color.fromRGBO(255, 255, 255, 0.87)
                      ),): number == 2 ? Text("Create daily routine",style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w700,
                          color:const Color.fromRGBO(255, 255, 255, 0.87)
                      ),):  Text("Orgonaize your tasks",style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w700,
                          color:const Color.fromRGBO(255, 255, 255, 0.87)
                          ),),
                      SizedBox(height: 20.h,),
                      number == 1 ? Text("You can easily manage all of your daily tasks in DoMe for free",style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color:const Color.fromRGBO(255, 255, 255, 0.87)
                      ),textAlign: TextAlign.center,) : number == 2 ? Text("In Uptodo  you can create your personalized routine to stay productive",style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color:const Color.fromRGBO(255, 255, 255, 0.87)
                      ),textAlign: TextAlign.center,) : Text("You can organize your daily tasks by adding your tasks into separate categories",style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color:const Color.fromRGBO(255, 255, 255, 0.87)
                      ),textAlign: TextAlign.center,),
                    ],
                  ),
                ),

            //button row

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                //back button

                TextButton(onPressed: (){
                  setState(() {
                    number -= 1;
                  });
                  if(number == 0){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return IntroPage();
                  },));}
                }, child: Text("BACK",style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color:const Color.fromRGBO(255, 255, 255, 0.44)
            ),)),

                //next button

                TextButton(onPressed: (){
                  setState(() {
                    number += 1;
                  });
                  if(number == 4){
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const StartPage();
                    },));}
                },style: TextButton.styleFrom(
                  backgroundColor:const Color.fromRGBO(136, 117, 255, 1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
                ), child: number == 3?Text("GET STARTED",style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color:const Color.fromRGBO(255, 255, 255, 1)
                ),):
                Text("NEXT",style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color:const Color.fromRGBO(255, 255, 255, 1)
                ),)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
