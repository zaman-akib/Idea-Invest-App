import 'package:flutter/material.dart';
import 'package:invest_idea_app/config/palette.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
        centerTitle: true,
      ),
      backgroundColor: Palette.darkBlue,
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Text(
                    '1. Project Management',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    '- Create a new project',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(height: 4,),
                  Text(
                    '- Add group members',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(height: 4,),
                  Text(
                    '- Add project investor',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(height: 4,),
                  Text(
                    '- Manage project updates',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white
                    ),
                  ),
                ],
              )
            ),
            Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      '2. Design Prototype',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      '- Create a new model',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                      ),
                    ),
                    SizedBox(height: 4,),
                    Text(
                      '- Add flowcharts',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                      ),
                    ),
                    SizedBox(height: 4,),
                    Text(
                      '- Add algorithms',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                      ),
                    ),
                    SizedBox(height: 4,),
                    Text(
                      '- Add SRS',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                      ),
                    ),
                  ],
                )
            ),
            Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      '3. Payment Procedure',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      '- Will be added soon',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                      ),
                    ),
                  ],
                )
            ),
            Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      '4. Reset Password',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      '- Will be added soon',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                      ),
                    ),
                  ],
                )
            ),
            Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      '5. Forums/Discussions',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(
                      '- Will be added soon',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white
                      ),
                    ),
                  ],
                )
            ),
          ],
        ),
      ),
    );
  }
}