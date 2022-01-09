import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:itschool/logIn/login_screen.dart';
import 'package:itschool/model/user_model.dart';
import 'package:itschool/screens/admin/admin_screen.dart';
import 'package:itschool/screens/lecturer/lec_screen.dart';
import 'package:itschool/screens/stu/student_screen.dart';

class Root extends StatefulWidget {
  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  //current user
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((firebaseuser) {
      if (firebaseuser == null) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
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
            Fluttertoast.showToast(msg: "Login Successful!");
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => StuHome()));
          } else if (loggedInUser.role == 'lecturer') {
            Fluttertoast.showToast(msg: "Login Successful!");
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
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
