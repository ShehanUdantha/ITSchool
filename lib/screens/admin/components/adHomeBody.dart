import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:itschool/model/user_model.dart';
import 'package:itschool/screens/admin/components/features_card.dart';
import 'package:itschool/screens/admin/components/header.dart';
import 'package:itschool/screens/admin/components/topic_section.dart';

class ABody extends StatefulWidget {
  @override
  State<ABody> createState() => _ABodyState();
}

class _ABodyState extends State<ABody> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Header(size: size, loggedInUser: loggedInUser),
          TopicSection(
            TopicName: 'Features',
          ),
          FeaCard(
            size: size,
            loggedInUser: loggedInUser,
          ),
        ],
      ),
    );
  }
}
