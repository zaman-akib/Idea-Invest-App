import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:invest_idea_app/config/palette.dart';
import 'package:invest_idea_app/config/variables.dart';
import 'package:invest_idea_app/pages/viewuser.dart';
import 'package:invest_idea_app/screens/main_drawer.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  Future<QuerySnapshot> searchresult;

  searchuser(String s) {
    var users = usercollection.where('username', isGreaterThanOrEqualTo: s).getDocuments();

    setState(() {
      searchresult = users;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.darkBlue,
      appBar: AppBar(
        titleSpacing: -3,
        title: Container(
          width: 350,
          child: TextFormField(
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(Icons.search, color: Palette.darkBlue,),
              hintStyle: mystyle(18, Palette.darkBlue, FontWeight.w400),
              hintText: 'Search...',
            ),
            onFieldSubmitted: searchuser,
          ),
        ),
      ),
      drawer: MainDrawer(),
      body: searchresult == null ? Center(
        child: Text('Search for users...', style: mystyle(30, Colors.white),)
      )
      : FutureBuilder(
        future: searchresult,
        builder: (BuildContext context, snapshot) {
          if(!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (BuildContext context, int index) {
              DocumentSnapshot user = snapshot.data.documents[index];
              return Card(
                elevation: 8.0,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(user['pro_pic']),
                  ),
                  title: Text(user['username'], style: mystyle(20, Palette.darkBlue, FontWeight.w600),),
                  trailing: InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ViewUserPage(user['uid']))),
                    child: Container(
                      width: 90,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.teal,
                      ),
                      child: Center(
                        child: Text(
                          "View",
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