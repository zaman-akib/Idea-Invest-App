import 'package:flutter/material.dart';
import 'package:invest_idea_app/config/palette.dart';
import 'package:invest_idea_app/config/variables.dart';
import 'package:invest_idea_app/pages/subscription.dart';
import 'package:invest_idea_app/screens/main_drawer.dart';

class ContestPage extends StatefulWidget {
  @override
  _ContestPageState createState() => _ContestPageState();
}

class _ContestPageState extends State<ContestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Contests'),
        titleSpacing: -3,
      ),
      backgroundColor: Palette.darkBlue,
      drawer: MainDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 14,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Center(
                      child: Icon(
                        Icons.lock_outline,
                        size: 100,
                        color: Colors.white,
                      ),
                    )
                ),
              ),
              Expanded(
                flex: 5,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Center(
                    child: Text(
                      'To Arrange Idea Contest',
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child:Builder(
                        builder: (context) => InkWell(
                          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> SubscriptionPage())),
                          focusColor: Colors.white,
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Palette.orange
                            ),
                            child: Center(
                              child: Text(
                                "Upgrade to Premium",
                                style: mystyle(22, Palette.darkBlue, FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                flex: 10,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Center(
                    child: Text(
                      'Or',
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child:Builder(
                        builder: (context) => InkWell(
                          onTap: () => Scaffold.of(context).showSnackBar(SnackBar(
                            content: Text('No contest is available now'),
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
                                "Join Contest",
                                style: mystyle(22, Palette.darkBlue, FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
