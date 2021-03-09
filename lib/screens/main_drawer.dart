import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:invest_idea_app/pages/boost_idea.dart';
import 'package:invest_idea_app/pages/design_prototype.dart';
import 'package:invest_idea_app/pages/help.dart';
import 'package:invest_idea_app/pages/projects.dart';
import 'package:invest_idea_app/pages/report_problem.dart';
import 'package:invest_idea_app/pages/saved_ideas.dart';
import 'package:invest_idea_app/pages/subscription.dart';
import 'package:invest_idea_app/screens/auth/auth.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import 'package:invest_idea_app/config/palette.dart';
import 'package:invest_idea_app/config/variables.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  String username;
  String pro_pic;

  initState() {
    super.initState();
    getcurrentuserinfo();
  }

  getcurrentuserinfo() async{
    var user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot userdoc = await usercollection.document(user.uid).get();

    setState(() {
      username = userdoc['username'];
      pro_pic = userdoc['pro_pic'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      child: Drawer(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20),
              color: Palette.darkBlue,
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(top: 15,),
                      child: pro_pic == null ? CircularProgressIndicator(backgroundColor: Colors.white,) :
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(pro_pic),
                      ),
                    ),
                    SizedBox(height: 8,),
                    Container(
                      child: username == null ? LinearProgressIndicator(backgroundColor: Colors.white,) :
                      Text(username, style: mystyle(12, Colors.white, FontWeight.w500),),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 3),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.business_center, color: Palette.darkBlue),
                    title: Text('Projects', style: TextStyle(color: Palette.darkBlue, fontSize: 18, fontWeight: FontWeight.w600),),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ProjectsPage()));
                    },
                    focusColor: Colors.teal,
                  ),
                  ListTile(
                    leading: Icon(Icons.mode_edit, color: Palette.darkBlue,),
                    title: Text('Prototype', style: TextStyle(color: Palette.darkBlue, fontSize: 18, fontWeight: FontWeight.w600),),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> DesignPrototypePage()));
                    },
                    focusColor: Colors.teal,
                  ),
                  ListTile(
                    leading: Icon(Icons.local_offer, color: Palette.darkBlue,),
                    title: Text('Get Premium', style: TextStyle(color: Palette.darkBlue, fontSize: 18, fontWeight: FontWeight.w600),),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SubscriptionPage()));
                    },
                    focusColor: Colors.teal,
                  ),
                  ListTile(
                    leading: Icon(Icons.lightbulb_outline, color: Palette.darkBlue,),
                    title: Text('Boost Idea', style: TextStyle(color: Palette.darkBlue, fontSize: 18, fontWeight: FontWeight.w600),),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> BoostIdeaPage()));
                    },
                    focusColor: Colors.teal,
                  ),
                  ListTile(
                    leading: Icon(Icons.turned_in, color: Palette.darkBlue),
                    title: Text('Saved Ideas', style: TextStyle(color: Palette.darkBlue, fontSize: 18, fontWeight: FontWeight.w600),),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> SavedIdeaPage()));
                    },
                    focusColor: Colors.teal,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(thickness: 1.5, color: Colors.grey, height: 5, indent: 4, endIndent: 7,),
                  ListTile(
                    leading: Icon(Icons.help_outline, color: Palette.darkBlue,),
                    title: Text('Help', style: TextStyle(color: Palette.darkBlue, fontSize: 18, fontWeight: FontWeight.w600),),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> HelpPage()));
                    },
                    focusColor: Colors.teal,
                  ),
                  ListTile(
                    leading: Icon(Icons.report_problem, color: Palette.darkBlue,),
                    title: Text('Report Problem', style: TextStyle(color: Palette.darkBlue, fontSize: 18, fontWeight: FontWeight.w600),),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ReportProblemPage()));
                    },
                    focusColor: Colors.teal,
                  ),
                  Divider(thickness: 1.5, color: Colors.grey, height: 5, indent: 4, endIndent: 7,),
                  ListTile(
                    leading: Icon(Icons.call_missed_outgoing, color: Palette.darkBlue,),
                    title: Text('Sign Out', style: TextStyle(color: Palette.darkBlue, fontSize: 18, fontWeight: FontWeight.w600),),
                    onTap: () {
                      context.signOut();
                      Navigator.of(context).push(AuthScreen.route);
                    },
                    focusColor: Colors.orange,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
