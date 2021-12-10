import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:itschool/logIn/login_screen.dart';
import 'package:itschool/model/user_model.dart';
import 'package:itschool/screens/admin/admin_screen.dart';
import 'package:itschool/screens/lecturer/lec_screen.dart';
import 'package:itschool/screens/stu/student_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((firebaseuser) {
      if (firebaseuser == null) {
        Timer(
            Duration(seconds: 5),
            () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => LoginScreen())));
      } else {
        FirebaseFirestore.instance
            .collection("users")
            .doc(firebaseuser.uid)
            .get()
            .then((uid) {
          this.loggedInUser = UserModel.fromMap(uid.data());

          if (loggedInUser.role == "admin") {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => AdminHome()));
          } else if (loggedInUser.role == "student") {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => StuHome()));
          } else if (loggedInUser.role == 'lecturer') {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => LecHome()));
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 75.0,
                  width: 75.0,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
