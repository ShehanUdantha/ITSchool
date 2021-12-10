import 'package:flutter/material.dart';
import 'package:itschool/chat/chat_Divider.dart';
import 'package:itschool/logIn/login_screen.dart';
import 'package:itschool/screens/stu/components/stHomeBody.dart';
import 'package:flutter_svg/svg.dart';
import 'package:itschool/screens/stu/sidebar/navigation_drawer_widget.dart';
import 'package:itschool/screens/stu/stu_screen/Calender/CalenderScreen.dart';
import 'package:itschool/screens/stu/stu_screen/news.dart';

class StuHome extends StatefulWidget {
  @override
  State<StuHome> createState() => _StuHomeState();
}

class _StuHomeState extends State<StuHome> {
  // @override
  // void initState() {
  //   super.initState();

  //   FirebaseAuth.instance.authStateChanges().listen((firebaseuser) {
  //     if (firebaseuser == null) {
  //       Navigator.of(context)
  //           .pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
  //     } else {}
  //   });
  // }

  int currentIndex = 0;

  final screens = [
    Body(),
    Calender_Screen(),
    ChScreen(),
    News(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: Builder(
              builder: (context) => IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: SvgPicture.asset("assets/icons/menu.svg"),
                  )),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {},
            ),
          ]),
      drawer: NavigationDrawerWidget(),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        //backgroundColor: Colors.white54,
        selectedItemColor: Color(0xff0b3140),
        unselectedItemColor: Color(0xff384c54),
        showUnselectedLabels: false,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calender',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.forum),
            label: 'Forum',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'News',
          ),
        ],
      ),
    );
  }
}
