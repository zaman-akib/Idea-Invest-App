import 'package:flutter/material.dart';
import 'package:invest_idea_app/config/palette.dart';
import 'package:invest_idea_app/config/variables.dart';

class ManageProjectPage extends StatefulWidget {
  @override
  _ManageProjectPageState createState() => _ManageProjectPageState();
}

class _ManageProjectPageState extends State<ManageProjectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Mange Project'),
      ),
      backgroundColor: Palette.darkBlue,
      body: Center(
        child: Text('Manage your project', style: mystyle(25, Colors.white),),
      ),
    );
  }
}
