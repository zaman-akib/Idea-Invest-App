import 'dart:async';
import 'package:flutter/material.dart';
import 'package:invest_idea_app/config/palette.dart';
import 'package:invest_idea_app/config/variables.dart';

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPagePageState createState() => _NotificationsPagePageState();
}

class _NotificationsPagePageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
        centerTitle: true,
      ),
      backgroundColor: Palette.darkBlue,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 200),
          child: Column(
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 30,),
              Text('No new notifications', style: mystyle(25, Colors.white),)
            ],
          ),
        )
      ),
    );
  }
}