import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/src/views/onboading/firstonbording.dart';
import 'package:todo_app/src/views/onboading/thirdonboading.dart';
import '../startpage.dart';

class SecondOnBoading extends StatelessWidget {
  const SecondOnBoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,

        //Skip button

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
            const Image(image: AssetImage("assets/images/Group 183.png")),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 25.w),
              child: Column(
                children: [
                  Text("Create daily routine",style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w700,
                      color:const Color.fromRGBO(255, 255, 255, 0.87)
                  ),),
                  SizedBox(height: 20.h,),
                  Text("In Uptodo  you can create your personalized routine to stay productive",style: TextStyle(
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const FirstOnBoading();
                  },));
                }, child: Text("BACK",style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color:const Color.fromRGBO(255, 255, 255, 0.44)
                ),)),

                //next button

                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ThirdOnBoadingPage();
                  },));
                },style: TextButton.styleFrom(
                    backgroundColor:const Color.fromRGBO(136, 117, 255, 1),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
                ), child: Text("NEXT",style: TextStyle(
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
