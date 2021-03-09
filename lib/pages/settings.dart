import 'package:flutter/material.dart';
import 'package:invest_idea_app/config/palette.dart';
import 'package:invest_idea_app/config/variables.dart';
import 'package:invest_idea_app/pages/edit_profile.dart';
import 'package:invest_idea_app/screens/main_drawer.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        titleSpacing: -3,
      ),
      drawer: MainDrawer(),
      backgroundColor: Palette.darkBlue,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                //flex: 10,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child:Builder(
                        builder: (context) => InkWell(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> EditProfilePage())),
                          focusColor: Colors.white,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Palette.orange
                            ),
                            child: Center(
                              child: Text(
                                "Change Username",
                                style: mystyle(22, Palette.darkBlue, FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child:Builder(
                        builder: (context) => InkWell(
                          onTap: () => Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('This feature will be added soon'),
                          )),
                          focusColor: Colors.white,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Palette.orange
                            ),
                            child: Center(
                              child: Text(
                                "Change Password",
                                style: mystyle(22, Palette.darkBlue, FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child:Builder(
                        builder: (context) => InkWell(
                          onTap: () => Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('This feature will be added soon'),
                          )),
                          focusColor: Colors.white,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Palette.orange
                            ),
                            child: Center(
                              child: Text(
                                "Privacy Settings",
                                style: mystyle(22, Palette.darkBlue, FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child:Builder(
                        builder: (context) => InkWell(
                          onTap: () => Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('This feature will be added soon'),
                          )),
                          focusColor: Colors.white,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Palette.orange
                            ),
                            child: Center(
                              child: Text(
                                "Change Language",
                                style: mystyle(22, Palette.darkBlue, FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child:Builder(
                        builder: (context) => InkWell(
                          onTap: () => Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('This feature will be added soon'),
                          )),
                          focusColor: Colors.white,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Palette.orange
                            ),
                            child: Center(
                              child: Text(
                                'Change Theme',
                                style: mystyle(22, Palette.darkBlue, FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}