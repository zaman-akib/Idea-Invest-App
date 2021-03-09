import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invest_idea_app/config/palette.dart';
import 'package:invest_idea_app/config/variables.dart';

class SubscriptionPage extends StatefulWidget {
  @override
  _SubscriptionPageState createState() => _SubscriptionPageState();
}

class _SubscriptionPageState extends State<SubscriptionPage> {
  int subscription_plan = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Get Premium'),
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
                      'Choose Your Subscription Plan',
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
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Container(
                          padding: const EdgeInsets.only(left: 16.0, right: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value: subscription_plan,
                              items: [
                                DropdownMenuItem(
                                  child: Text('\$19 per month', style: mystyle(18),),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text('\$99 per six-month', style: mystyle(18),),
                                  value: 2,
                                ),
                                DropdownMenuItem(
                                  child: Text('\$199 per year', style: mystyle(18),),
                                  value: 3,
                                ),
                              ],
                              onChanged: (value){
                                setState(() {
                                  subscription_plan = value;
                                });
                              },
                              hint: Text('Select Gender'),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 80),
                          child:Builder(
                          builder: (context) => InkWell(
                            onTap: () => Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text('Payment procedure will be added soon'),
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
                                  "Subscribe",
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
