import 'dart:async';

import 'package:flutter/material.dart';
import 'package:invest_idea_app/config/palette.dart';
import 'package:invest_idea_app/config/variables.dart';
import 'package:invest_idea_app/screens/home.dart';

class ReportProblemPage extends StatefulWidget {
  @override
  _ReportProblemPageState createState() => _ReportProblemPageState();
}

class _ReportProblemPageState extends State<ReportProblemPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Report Problem'),
          centerTitle: true,
        ),
        backgroundColor: Palette.darkBlue,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 10,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              child: TextField(
                                expands: true,
                                maxLines: null,
                                textAlign: TextAlign.start,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  hintText: 'Write your report here',
                                  fillColor: Colors.white,
                                  contentPadding: EdgeInsets.all(15),
                                ),
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child:Builder(
                          builder: (context) => InkWell(
                            onTap: () {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Report Sent'),
                              ));
                              Timer(Duration(seconds: 1), () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
                              });
                            },
                            focusColor: Colors.white,
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Palette.orange
                              ),
                              child: Center(
                                child: Text(
                                  "Send Report",
                                  style: mystyle(22, Palette.darkBlue, FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
