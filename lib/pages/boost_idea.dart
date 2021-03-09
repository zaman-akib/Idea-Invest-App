import 'package:flutter/material.dart';
import 'package:invest_idea_app/config/palette.dart';
import 'package:invest_idea_app/config/variables.dart';
import 'package:invest_idea_app/pages/subscription.dart';

class BoostIdeaPage extends StatefulWidget {
  @override
  _BoostIdeaPageState createState() => _BoostIdeaPageState();
}

class _BoostIdeaPageState extends State<BoostIdeaPage> {
  TextEditingController no_of_ideas =  TextEditingController();
  TextEditingController no_of_days =  TextEditingController();
  int x = 1;
  int y = 1;
  int cost = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Boost Idea'),
          centerTitle: true,
        ),
        backgroundColor: Palette.darkBlue,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 32.0, right: 32.0, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Choose Your \nBoosting Plan',
                      style: const TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 10,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: TextFormField(
                                controller: no_of_ideas,
                                decoration: InputDecoration(
                                  filled: true,
                                  hintText: 'Number of ideas',
                                  fillColor: Colors.white,
                                ),
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: TextFormField(
                                controller: no_of_days,
                                decoration: InputDecoration(
                                  filled: true,
                                  hintText: 'Number of days',
                                  fillColor: Colors.white,
                                ),
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: Text('Total cost : $cost \$', style: mystyle(25, Colors.white),)
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 40),
                        child:Builder(
                          builder: (context) => InkWell(
                            onTap: () {
                              setState(() {
                                if(no_of_days.text == '' || no_of_ideas.text == ''){
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      content: Text('Incorrect input'))
                                  );
                                  cost = 0;
                                }
                                else{
                                  x = int.parse(no_of_days.text);
                                  y = int.parse(no_of_ideas.text);
                                  cost =  x * y * 1 ;
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                    content: Text('Payment procedure will be added soon'),
                                  ));
                                }
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
                                  "Start Boosting",
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
