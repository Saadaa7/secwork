
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart" hide badge;
import 'package:freelance_app/screens/activity/activity.dart';

import 'package:freelance_app/screens/homescreen/components/categories.dart';
import 'package:freelance_app/screens/profile/profile.dart';
import 'package:freelance_app/utils/colors.dart';
import 'package:freelance_app/screens/homescreen/components/posted_jobs.dart';
import 'package:freelance_app/screens/homescreen/sidebar.dart';
import 'package:freelance_app/screens/search/search_screen.dart';
import 'package:uuid/uuid.dart';

import 'components/job_post.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavigationPage(
        title: "getJOBS",
      ),
    );
  }
}

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _BottomNavigationPageState createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  late int currentIndex;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  void changePage(int? index) {
    setState(() {
      currentIndex = index!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final _uid = user!.uid;
    print(_uid);
    return Scaffold(
      body: <Widget>[
        const Homepage(),
        const Search(),
        const JobsActivity(),
        ProfilePage(
          userID: _uid,
        ),
      ][currentIndex],
      floatingActionButton: currentIndex == 0 || currentIndex == 1
          ? FloatingActionButton(
              backgroundColor:  Colors.deepPurple,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => Upload(
                            userID: _uid,
                          ) //const LoginScreen(),
                      ),
                );
              },
              child: const Icon(
                Icons.add_rounded,
                //size: 40,
                color: Colors.white,
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNavigationBar(
    backgroundColor: Colors.white,

    currentIndex: currentIndex,
    onTap: changePage,

        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.blueGrey,
          icon: Icon(
      Icons.dashboard,
        color: Colors.black,
      ),
      activeIcon: Icon(
        Icons.dashboard,
        color: Colors.white,
      ),
      label:'Home',
        ),

          BottomNavigationBarItem(
            backgroundColor: Colors.blueGrey,
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            label:'Search',
          ),

          BottomNavigationBarItem(
            backgroundColor: Colors.blueGrey,
            icon:Icon(
              Icons.library_books,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.library_books,
              color: Colors.white,
            ),
            label:'Activity',
          ),

          BottomNavigationBarItem(
            backgroundColor: Colors.blueGrey,
            icon:Icon(
              Icons.person_outline,
              color: Colors.black,
            ),
            activeIcon: Icon(
              Icons.person_outline_rounded,
              color: Colors.white,
            ),
            label:'Profile',
          ),
      ],

      )
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: white,
        iconTheme: const IconThemeData(
          color: Colors.deepPurple,
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 60),
          child: Image(
            height: 40,

            image: AssetImage("assets/images/logo.png"),),
        ),

      ),

      body: SafeArea(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.only( top: 20),
              child: Center(
                child: Text(
                  "Find Your Perfect ",
                  style: TextStyle(fontFamily: 'Rubik', fontSize: 30),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only( bottom: 15),
              child: Center(
                child: Text(
                  "Job",

                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            // Category(),
            SizedBox(
              height: 10,
            ),
            Postedjob(),
            //Bottomnavbar(),
          ],
        ),
      ),
    );
  }
}
