import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/src/views/navbar/bottomnavpage.dart';
import 'package:todo_app/src/services/authservice.dart';
import 'package:todo_app/src/views/authviews/registerpage.dart';
import 'package:todo_app/src/views/startpage.dart';
import 'package:todo_app/src/wraper.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {

    final _formKey = GlobalKey<FormState>();

    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    Future<void> _signInWithEmailAndPassword()async{
      try{
        await AuthService().signInWithEmailAndPassword(
            email: _emailController.text,
            password: _passwordController.text);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const WrappperPage();
        },));
      }catch(error){
        print("Error : $error");
      }
    }

    Future<void> _signInWIthGoogle(BuildContext context)async{
      try{
        await AuthService().signInWithGoogle();
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const BottomNavPage();
        },));
      }catch(error){
        print("Error ; $error");
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const StartPage();
          },));
        }, icon:const Icon(Icons.arrow_back)),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
        
            Form(
                key: _formKey,
                child: SizedBox(
              width: 327.w,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Login",style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w700,
                          color:const Color.fromRGBO(255, 255, 255, 0.87)
                      ),),
                    ],
                  ),
                  SizedBox(height: 30.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Text("Email",style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color:const Color.fromRGBO(255, 255, 255, 0.87)
                        ),),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: _emailController,
                    validator: (value) {
                      if(value!.isEmpty){
                        return "Please enter your email";
                      }else {
                        return null;
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "masha@gmail.com",
                      filled: true,
                      fillColor:const Color.fromRGBO(29, 29, 29, 1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide:const BorderSide(
                          color: Color.fromRGBO(151, 151, 151, 1),
                          width: 0.8
                        )
                      )
                    ),
                  ),
                  SizedBox(height: 20.h,),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.h),
                        child: Text("Password",style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color:const Color.fromRGBO(255, 255, 255, 0.87)
                        ),),
                      ),
                    ],
                  ),
                  TextFormField(
                    controller: _passwordController,
                    validator: (value) {
                      if(value!.isEmpty){
                        return "Please enter your password";
                      }else {
                        return null;
                      }
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                        filled: true,
                        fillColor:const Color.fromRGBO(29, 29, 29, 1),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                            borderSide:const BorderSide(
                                color: Color.fromRGBO(151, 151, 151, 1),
                                width: 0.8
                            )
                        )
                    ),
                  ),
        
                ],
              ),
            )),
            Padding(
              padding: EdgeInsets.only(top: 60.h,bottom: 40.h),
              child: TextButton(onPressed: ()async{
                if(_formKey.currentState!.validate()){
                  await _signInWithEmailAndPassword();
                }
              },
                  style: TextButton.styleFrom(
                      backgroundColor:const Color.fromRGBO(134, 135, 231, 1),
                      fixedSize: Size.fromWidth(327.w),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      )
                  ),
                  child: Text("Login",style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color:const Color.fromRGBO(255, 255, 255, 1)
                  ))),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,            children: [
                Container(
                  width: 154,
                  height: 1,
                  color:const Color.fromRGBO(151, 151, 151, 1),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text("or",style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color:const Color.fromRGBO(255, 255, 255, 1)
                  )),
                ),
                Container(
                  width: 154,
                  height: 1,
                  color:const Color.fromRGBO(151, 151, 151, 1),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 30.h,bottom: 40.h),
              child: Column(
                children: [
                  TextButton(onPressed: ()async{
                    await _signInWIthGoogle(context);
                  },
                      style: TextButton.styleFrom(
                          fixedSize: Size.fromWidth(327.w),
                          shape: RoundedRectangleBorder(
                            side:const BorderSide(width: 1,color: Color.fromRGBO(136, 117, 255, 1)),
                            borderRadius: BorderRadius.circular(4),
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image:const AssetImage("assets/images/google1.png"),width: 24.w,height: 24.h,),
                          SizedBox(width: 5.w,),
                          Text("Login with Google",style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color:const Color.fromRGBO(255, 255, 255, 0.87)
                          )),
                        ],
                      )),
                  SizedBox(height: 10.h,),
                  TextButton(onPressed: (){},
                      style: TextButton.styleFrom(
                          fixedSize: Size.fromWidth(327.w),
                          shape: RoundedRectangleBorder(
                            side:const BorderSide(width: 1,color: Color.fromRGBO(136, 117, 255, 1)),
                            borderRadius: BorderRadius.circular(4),
                          )
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image:const AssetImage("assets/images/apple1.png"),width: 24.w,height: 24.h,),
                          SizedBox(width: 5.w,),
                          Text("Login with Appe",style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color:const Color.fromRGBO(255, 255, 255, 0.87)
                          )),
                        ],
                      )),
                ],
              ),
            ),Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don’t have an account? ",style: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color:const Color.fromRGBO(255, 255, 255, 0.87)
    ),),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return const RegisterPage();
                    },));
                  },
                  child: Text("Register",style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color:const Color.fromRGBO(255, 255, 255, 1)
                  ),),
                )
              ],
            )
        
        
          ],
        ),
      ),
    );
  }
}
