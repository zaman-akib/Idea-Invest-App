import 'package:flutter/material.dart';
import 'package:invest_idea_app/config/palette.dart';
import 'package:invest_idea_app/pages/contest.dart';
import 'package:invest_idea_app/pages/ideas.dart';
import 'package:invest_idea_app/pages/profile.dart';
import 'package:invest_idea_app/pages/search.dart';
import 'package:invest_idea_app/pages/settings.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
    builder: (context) => const HomePage(),
  );

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 0;
  List pageoptions = [
    IdeasPage(),
    SearchPage(),
    ProfilePage(),
    ContestPage(),
    SettingsPage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageoptions[page],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            page = index;
          });
        },
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.white,
        currentIndex: page,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Palette.darkBlue,
        items: [
          BottomNavigationBarItem(
            title: Text('Ideas',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: Icon(Icons.home, size: 28, color: Colors.white,),
          ),
          BottomNavigationBarItem(
            title: Text('Search',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: Icon(Icons.search, size: 28, color: Colors.white,),
          ),
          BottomNavigationBarItem(
            title: Text('Profile',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: Icon(Icons.person, size: 28, color: Colors.white,),
          ),
          BottomNavigationBarItem(
            title: Text('Contests',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: Icon(Icons.assignment, color: Colors.white,),
          ),
          BottomNavigationBarItem(
            title: Text('Settings',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            icon: Icon(Icons.settings, size: 28, color: Colors.white,),
          ),
        ]
      ),
    );
  }
}