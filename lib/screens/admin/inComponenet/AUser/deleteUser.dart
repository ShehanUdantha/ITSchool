import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itschool/model/user_model.dart';

class DelUScreen extends StatefulWidget {
  const DelUScreen({
    Key? key,
    required this.loggedInUser,
    required this.title,
  }) : super(key: key);
  final UserModel loggedInUser;
  final String title;

  @override
  State<DelUScreen> createState() => _DelUScreenState();
}

class _DelUScreenState extends State<DelUScreen> {
  CollectionReference ref = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(widget.title),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: ref.snapshots(),
        builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var doc = snapshot.data!.docs;
                  return Card(
                    child: ListTile(
                      title: Text(
                        doc[index]['indexNo'],
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontSize: 20,
                              color: Color(0xff0b3140),
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      subtitle: Column(
                        children: <Widget>[
                          Text(
                            doc[index]['role'],
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF3C4046),
                              ),
                            ),
                          ),
                          Text(
                            doc[index]['email'],
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF3C4046),
                              ),
                            ),
                          ),
                        ],
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),
                      leading: IconButton(
                        icon: Icon(
                          Icons.delete,
                          size: 30.0,
                        ),
                        color: Colors.red,
                        onPressed: () {
                          snapshot.data!.docs[index].reference.delete();
                          Fluttertoast.showToast(
                              msg: "User deleted successfully!");
                        },
                      ),
                    ),
                  );
                });
          } else
            return Text("");
        },
      ),
    );
  }
}
