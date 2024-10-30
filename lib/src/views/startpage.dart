import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/src/views/authviews/loginpage.dart';
import 'package:todo_app/src/views/authviews/registerpage.dart';
import 'package:todo_app/src/views/onboading/firstonbording.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(

        //navigate to first onboading screen

        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const FirstOnBoading();
          },));
        }, icon:const Icon(Icons.arrow_back_ios_new)),
      ),


      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding:  EdgeInsets.only(top: 49.h,left: 42.w,right: 42.w),
            child: Column(
              children: [
                Text("Welcome to UpTodo",style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.w700,
                  color:const Color.fromRGBO(255, 255, 255, 0.87)
                ),),
                SizedBox(height: 20.h,),
                Text("Please login to your account or create new account to continue",style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color:const Color.fromRGBO(255, 255, 255, 0.67)
                ),textAlign: TextAlign.center,)
              ],
            ),
          ),
          Column(
            children: [

              //login button

              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const LoginPage();
                },));
              },style: TextButton.styleFrom(
                fixedSize: Size.fromWidth(327.w),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                backgroundColor:const Color.fromRGBO(136, 117, 255, 1)
              ), child: Text("LOGIN",style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color:const Color.fromRGBO(255, 255, 255, 1)
              ),)),
              SizedBox(height: 10.h,),

              //register button

              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const RegisterPage();
                },));
              },style: TextButton.styleFrom(
                  fixedSize: Size.fromWidth(327.w),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4),side: BorderSide(color:Color.fromRGBO(142, 124, 255, 1) )),
              ), child: Text("CREATE ACCOUNT",style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color:const Color.fromRGBO(255, 255, 255, 1)
              ),)),
              SizedBox(height: 20.h,)
            ],
          )
        ],
      ),
    );
  }
}
