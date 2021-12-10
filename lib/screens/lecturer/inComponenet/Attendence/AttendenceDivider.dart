import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itschool/model/user_model.dart';
import 'package:itschool/screens/lecturer/inComponenet/Attendence/listModule.dart';

class AttendenceScreen extends StatefulWidget {
  const AttendenceScreen({
    Key? key,
    required this.loggedInUser,
  }) : super(key: key);
  final UserModel loggedInUser;

  @override
  _AttendenceScreenState createState() => _AttendenceScreenState();
}

class _AttendenceScreenState extends State<AttendenceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 1,
            height: 480,
            child: GridView.count(
              crossAxisCount: 1,
              childAspectRatio: (1.8 / .4),
              controller: new ScrollController(keepScrollOffset: false),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: <Widget>[
                MyFeat(
                  title: '7th Batch',
                  dbtitle: '7',
                  module: '7thModules',
                  colour: Color(0xff00bfa5),
                  icon: Icons.circle,
                  loggedInUser: widget.loggedInUser,
                ),
                MyFeat(
                  title: '8th Batch',
                  dbtitle: '8',
                  module: '8thModules',
                  colour: Color(0xff00bfa5),
                  icon: Icons.circle,
                  loggedInUser: widget.loggedInUser,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyFeat extends StatelessWidget {
  MyFeat({
    required this.title,
    required this.module,
    required this.dbtitle,
    required this.icon,
    required this.colour,
    required this.loggedInUser,
  });

  final String title, module;
  final String dbtitle;
  final IconData icon;
  final Color colour;
  final UserModel loggedInUser;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          if (title == "7th Batch") {
            Checker(context);
          }
          if (title == "8th Batch") {
            Checker(context);
          }
        },
        splashColor: colour,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      icon,
                      size: 30.0,
                      color: Color(0xff0b3140),
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      title,
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF3C4046),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void Checker(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LiMScreen(
                  loggedInUser: loggedInUser,
                  dtitle: dbtitle,
                  module: module,
                )));
  }
}
