import 'package:flutter/material.dart';
import 'package:invest_idea_app/config/palette.dart';
import 'package:invest_idea_app/config/variables.dart';

class SavedIdeaPage extends StatefulWidget {
  @override
  _SavedIdeaPageState createState() => _SavedIdeaPageState();
}

class _SavedIdeaPageState extends State<SavedIdeaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Saved Ideas'),
          centerTitle: true,
        ),
        floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
            child: Icon(Icons.library_add, size: 32, color: Palette.darkBlue,),
            backgroundColor: Palette.orange,
            onPressed: ()=>
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Add new category'),
                )),
          ),
        ),
        backgroundColor: Palette.darkBlue,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 42.0, right: 42.0, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child:Builder(
                          builder: (context) => InkWell(
                            onTap: () {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Empty List'),
                              ));
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
                                  "Business Ideas",
                                  style: mystyle(22, Palette.darkBlue, FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child:Builder(
                          builder: (context) => InkWell(
                            onTap: () {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Empty List'),
                              ));
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
                                  "Sports Ideas",
                                  style: mystyle(22, Palette.darkBlue, FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child:Builder(
                          builder: (context) => InkWell(
                            onTap: () {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Empty List'),
                              ));
                            },
                            focusColor: Colors.white,
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: Palette.orange
                              ),
                              child: Center(
                                child: Text(
                                  "Health Innovation Ideas",
                                  style: mystyle(22, Palette.darkBlue, FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child:Builder(
                          builder: (context) => InkWell(
                            onTap: () {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Empty List'),
                              ));
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
                                  "Robotics Ideas",
                                  style: mystyle(22, Palette.darkBlue, FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child:Builder(
                          builder: (context) => InkWell(
                            onTap: () {
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text('Empty List'),
                              ));
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
                                  "Android App Ideas",
                                  style: mystyle(22, Palette.darkBlue, FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
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
