import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_app/src/services/authservice.dart';
import 'package:todo_app/src/views/authviews/loginpage.dart';

import 'navbar/bottomnavpage.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {


  //controllers for textfeilds
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();

  //get the current user
  final user = FirebaseAuth.instance.currentUser;


  String username = '';
  String image = "";
  String about = "";


  //method for image uploading
  Future<void> _pickImage(ImageSource source) async{
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if(pickedFile != null){
      setState(() {
        image = pickedFile.path;
      });
    }
  }

  @override
  void initState() {

    //get the user details from SharedPreferences
    //set user details to variables at initstate
    AuthService().getUserDetails(user!.uid).then((value){
      if(value![0] != ''){
        setState(() {
          username = value[0];
          image = value[1];
          about = value[2];
        });
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 30.h,left: 10.w,right: 10.w,bottom: 10.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.h,),
              Text("Profile",style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                  color:const Color.fromRGBO(255, 255, 255, 0.87)
              ),),
              SizedBox(height: 20.h,),

              //display profile image
              SizedBox(
                height: 86.h,
                child: Stack(
                  children: [

                    //check the image is a network image or not
                    image.contains("http")?CircleAvatar(
                        backgroundImage:NetworkImage(image),
                        backgroundColor: Colors.transparent,
                        // child: Image(image: AssetImage(image),fit: BoxFit.fill,),
                        radius: 42
                    ):CircleAvatar(

                        // check the profile image is null or not
                        // if it is null display the assetImage
                        // if it is not null  display the image
                        backgroundImage:image == "" ? const AssetImage("assets/images/profile.png"):FileImage(File(image)),
                        backgroundColor: Colors.transparent,
                        // child: Image(image: AssetImage(image),fit: BoxFit.fill,),
                        radius: 42
                    ),

                    // button for edit profile image
                    Positioned(
                        bottom: -15,
                        right: -10,
                        child: IconButton(onPressed: (){
                          showDialog(context: context, builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                              child: SizedBox(
                                height: 200.h,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text("Change Image",style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          color:const Color.fromRGBO(255, 255, 255, 0.87)
                                      ),),
                                      const Divider(),
                                      IconButton(onPressed: ()=>
                                          _pickImage(ImageSource.gallery)
                                          ,
                                          style: IconButton.styleFrom(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(4),
                                                  side:const BorderSide(color:  Color.fromRGBO(255, 255, 255, 0.87))
                                              )
                                          ),
                                          icon: const Icon(Icons.upload)),
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
                                            await AuthService().updateUsername(user!.uid, username, image, about);
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
                                              child: Text("Save",style: TextStyle(
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
                        }, icon: const Icon(Icons.add_a_photo_outlined)))
                  ],
                ),
              ),
              SizedBox(height: 10.h,),

              // display the username
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(username,style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color:const Color.fromRGBO(255, 255, 255, 0.87)
                  ),),

                  // button for edit username
                  IconButton(onPressed: (){
                    showDialog(context: context, builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        child: SizedBox(
                          height: 200.h,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Change Name",style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color:const Color.fromRGBO(255, 255, 255, 0.87)
                                ),),
                                Text(username,style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                    color:const Color.fromRGBO(255, 255, 255, 0.87)
                                ),),
                                const Divider(),
                                TextField(
                                  controller: _usernameController,
                                  decoration: InputDecoration(
                                      hintText: username,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(4),
                                          borderSide:const  BorderSide(color: Color.fromRGBO(255, 255, 255, 0.87) )
                                      )
                                  ),
                                ),
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
                                      setState(() {
                                        username = _usernameController.text;
                                      });
                                      await AuthService().updateUsername(user!.uid, username, image, about);
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
                                        child: Text("Save",style: TextStyle(
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
                  }, icon:const Icon(Icons.edit)),
                ],
              ),
              SizedBox(height: 5.h,),

              // display the about
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(about,style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      color:const Color.fromRGBO(255, 255, 255, 0.87)
                  ),),

                  // button for edit about
                  IconButton(onPressed: (){
                    showDialog(context: context, builder: (context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        child: SizedBox(
                          height: 200.h,
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Change About Section",style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color:const Color.fromRGBO(255, 255, 255, 0.87)
                                ),),
                                Text(about,style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w400,
                                    color:const Color.fromRGBO(255, 255, 255, 0.87)
                                ),),
                                const Divider(),
                                TextField(
                                  controller: _aboutController,
                                  decoration: InputDecoration(
                                      hintText: about,
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(4),
                                          borderSide:const  BorderSide(color: Color.fromRGBO(255, 255, 255, 0.87) )
                                      )
                                  ),
                                ),
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
                                      setState(() {
                                        about = _aboutController.text;
                                      });
                                      await AuthService().updateUsername(user!.uid, username, image, about);
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
                                        child: Text("Save",style: TextStyle(
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
                  }, icon:const Icon(Icons.edit)),
                ],
              ),
              SizedBox(height: 20.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(onPressed: (){},
                      style: TextButton.styleFrom(
                        fixedSize: Size.fromWidth(154.w),
                        backgroundColor:const Color.fromRGBO(54, 54, 54, 1),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
                      ),
                      child: Text("10 Task left",style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color:const Color.fromRGBO(255, 255, 255, 1)
                  ),)),
                  TextButton(onPressed: (){},
                      style: TextButton.styleFrom(
                          fixedSize: Size.fromWidth(154.w),
                          backgroundColor:const Color.fromRGBO(54, 54, 54, 1),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))
                      ),
                      child: Text("5 Task done",style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color:const Color.fromRGBO(255, 255, 255, 1)
                      ),))
                ],
              ),
              SizedBox(height: 20.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Settings",style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color:const Color.fromRGBO(175, 175, 175, 1)
                  ),),
                ],
              ),
              SizedBox(height: 10.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.settings),
                      SizedBox(width: 10.w,),
                      Text("App Settings",style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color:const Color.fromRGBO(255, 255, 255, 0.87)
                      ),),
                    ],
                  ),
                  const Icon(Icons.arrow_forward_ios),
                ],
              ),
              SizedBox(height: 20.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Account",style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color:const Color.fromRGBO(175, 175, 175, 1)
                  ),),
                ],
              ),
              SizedBox(height: 10.h,),

              // edit username
              GestureDetector(
                onTap: () {
                  showDialog(context: context, builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      child: SizedBox(
                        height: 200.h,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Change Name",style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color:const Color.fromRGBO(255, 255, 255, 0.87)
                          ),),
                              Text(username,style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  color:const Color.fromRGBO(255, 255, 255, 0.87)
                              ),),
                              const Divider(),
                              TextField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                  hintText: username,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(4),
                                    borderSide:const  BorderSide(color: Color.fromRGBO(255, 255, 255, 0.87) )
                                  )
                                ),
                              ),
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
                                    setState(() {
                                      username = _usernameController.text;
                                    });
                                    await AuthService().updateUsername(user!.uid, username, image, about);
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
                                      child: Text("Save",style: TextStyle(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.person_outline),
                        SizedBox(width: 10.w,),
                        Text("Change account name",style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color:const Color.fromRGBO(255, 255, 255, 0.87)
                        ),),
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              SizedBox(height: 10.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.vpn_key_outlined),
                      SizedBox(width: 10.w,),
                      Text("Change account password",style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color:const Color.fromRGBO(255, 255, 255, 0.87)
                      ),),
                    ],
                  ),
                  const Icon(Icons.arrow_forward_ios),
                ],
              ),
              SizedBox(height: 10.h,),

              // edit image
              GestureDetector(
                onTap:() {
                  showDialog(context: context, builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      child: SizedBox(
                        height: 200.h,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Change Image",style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color:const Color.fromRGBO(255, 255, 255, 0.87)
                              ),),
                              const Divider(),
                              IconButton(onPressed: ()=>
                                _pickImage(ImageSource.gallery)
                              ,
                                  style: IconButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4),
                                      side:const BorderSide(color:  Color.fromRGBO(255, 255, 255, 0.87))
                                    )
                                  ),
                                  icon: const Icon(Icons.upload)),
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
                                    await AuthService().updateUsername(user!.uid, username, image, about);
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
                                      child: Text("Save",style: TextStyle(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.camera_alt_outlined),
                        SizedBox(width: 10.w,),
                        Text("Change account Image",style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color:const Color.fromRGBO(255, 255, 255, 0.87)
                        ),),
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              SizedBox(height: 20.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Uptodo",style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color:const Color.fromRGBO(175, 175, 175, 1)
                  ),),
                ],
              ),
              SizedBox(height: 10.h,),

              // edit about
              GestureDetector(
                onTap: () {
                  showDialog(context: context, builder: (context) {
                    return Dialog(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                      child: SizedBox(
                        height: 200.h,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Change About Section",style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w400,
                                  color:const Color.fromRGBO(255, 255, 255, 0.87)
                              ),),
                              Text(about,style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w400,
                                  color:const Color.fromRGBO(255, 255, 255, 0.87)
                              ),),
                              const Divider(),
                              TextField(
                                controller: _aboutController,
                                decoration: InputDecoration(
                                    hintText: about,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(4),
                                        borderSide:const  BorderSide(color: Color.fromRGBO(255, 255, 255, 0.87) )
                                    )
                                ),
                              ),
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
                                    setState(() {
                                      about = _aboutController.text;
                                    });
                                    await AuthService().updateUsername(user!.uid, username, image, about);
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
                                      child: Text("Save",style: TextStyle(
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.window_outlined),
                        SizedBox(width: 10.w,),
                        Text("About US",style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color:const Color.fromRGBO(255, 255, 255, 0.87)
                        ),),
                      ],
                    ),
                    const Icon(Icons.arrow_forward_ios),
                  ],
                ),
              ),
              SizedBox(height: 10.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.info_outline),
                      SizedBox(width: 10.w,),
                      Text("FAQ",style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color:const Color.fromRGBO(255, 255, 255, 0.87)
                      ),),
                    ],
                  ),
                  const Icon(Icons.arrow_forward_ios),
                ],
              ),
              SizedBox(height: 10.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.flash_on_outlined),
                      SizedBox(width: 10.w,),
                      Text("Help & Feedback",style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color:const Color.fromRGBO(255, 255, 255, 0.87)
                      ),),
                    ],
                  ),
                  const Icon(Icons.arrow_forward_ios),
                ],
              ),
              SizedBox(height: 10.h,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.thumb_up_outlined),
                      SizedBox(width: 10.w,),
                      Text("Support US",style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color:const Color.fromRGBO(255, 255, 255, 0.87)
                      ),),
                    ],
                  ),
                  const Icon(Icons.arrow_forward_ios),
                ],
              ),
              SizedBox(height: 20.h,),

              // sign out
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async{
                      await AuthService().signOut();
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        return const LoginPage();
                      },));
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.logout,color: Color.fromRGBO(255, 73, 73, 1) ,),
                        Text("Log Out",style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color:const Color.fromRGBO(255, 73, 73, 1)
                        ),),
                      ],
                    ),
                  )
          
                ],
              ),
              SizedBox(height: 20.h,),
            ],
          ),
        ),
      ),
    );
  }
}
