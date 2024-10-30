import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/src/views/onboading/firstonbording.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _goToHome();
  }

  // startup display method

  _goToHome()async{
    await Future.delayed(const Duration(milliseconds: 3000,),(){});
    Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const FirstOnBoading();
    },));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(image: AssetImage("assets/images/Group 151.png")),
            Text("UpTodo",style: TextStyle(
              fontSize: 40.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white
            ),)
          ],
        ),
      ),
    );
  }
}
