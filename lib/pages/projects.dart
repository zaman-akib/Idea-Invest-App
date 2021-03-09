import 'package:flutter/material.dart';
import 'package:invest_idea_app/config/palette.dart';
import 'package:invest_idea_app/config/variables.dart';
import 'package:invest_idea_app/pages/manage_project.dart';

class ProjectsPage extends StatefulWidget {
  @override
  _ProjectsPageState createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Projects'),
      ),
      backgroundColor: Palette.darkBlue,
      floatingActionButton: Builder(
      builder: (context) => FloatingActionButton(
        child: Icon(Icons.playlist_add, size: 32, color: Palette.darkBlue,),
        backgroundColor: Palette.orange,
        onPressed: ()=>
            Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('"Add New Project" feature will be added soon'),
            )),
      ),
      ),
      body: StreamBuilder(
        builder: (context, snapshot){
          return ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Colors.white,
                child: ListTile(
                  title: Text('Project - $index', style: mystyle(22, Colors.black),),
                  trailing: InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ManageProjectPage()));
                    },
                    focusColor: Colors.white,
                    child: Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.teal
                      ),
                      child: Center(
                        child: Text(
                          "Manage",
                          style: mystyle(20, Palette.darkBlue, FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
