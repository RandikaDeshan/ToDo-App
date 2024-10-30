import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/src/views/navbar/bottomnavpage.dart';
import 'package:todo_app/src/views/authviews/loginpage.dart';

class WrappperPage extends StatefulWidget {
  const WrappperPage({super.key});

  @override
  State<WrappperPage> createState() => _WrappperPageState();
}

class _WrappperPageState extends State<WrappperPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return const BottomNavPage();
        } else {
          return const LoginPage();
        }
      },
    );;
  }
}
