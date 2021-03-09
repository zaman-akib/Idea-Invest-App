import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invest_idea_app/config/palette.dart';
import 'package:invest_idea_app/config/variables.dart';
import 'package:invest_idea_app/pages/comments.dart';
import 'package:invest_idea_app/pages/notifications.dart';
import 'package:invest_idea_app/pages/post_idea.dart';
import 'package:invest_idea_app/screens/main_drawer.dart';
import 'package:timeago/timeago.dart' as tAgo;

class IdeasPage extends StatefulWidget {
  @override
  _IdeasPageState createState() => _IdeasPageState();
}

class _IdeasPageState extends State<IdeasPage> {
  String _uid;
  initState() {
    super.initState();
    getcurrentuserid();
  }

  getcurrentuserid() async{
    var user = await FirebaseAuth.instance.currentUser();
    setState(() {
      _uid = user.uid;
    });
  }

  likepost(String documentid) async{
    var user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot document = await ideacollection.document(documentid).get();

    if(document['likes'].contains(user.uid)){
      ideacollection.document(documentid).updateData({
        'likes': FieldValue.arrayRemove([user.uid]),
      });
    }
    else{
      ideacollection.document(documentid).updateData({
        'likes': FieldValue.arrayUnion([user.uid]),
      });
    }
  }

  sharepost(String documentid, String idea) async{
    Share.text('IdeaHub', idea, 'text/plain');
    DocumentSnapshot document = await ideacollection.document(documentid).get();
    ideacollection.document(documentid).updateData({
      'share_count': document['share_count'] + 1,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ideaVest'),
        backgroundColor: Palette.darkBlue,
        titleSpacing: -3,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.notifications),
            color: Colors.white,
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> NotificationsPage()));
            },
          ),
        ],
      ),
      backgroundColor: Palette.darkBlue,
      drawer: MainDrawer(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 32,),
        backgroundColor: Palette.darkBlue,
        onPressed: ()=>
          Navigator.push(context, MaterialPageRoute(builder: (context)=> PostIdeaPage())),
      ),
      body: StreamBuilder(
        stream: ideacollection.orderBy('time', descending: true).snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(
                child: CircularProgressIndicator(backgroundColor: Palette.darkBlue,),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
              itemBuilder: (BuildContext context, int index){
                DocumentSnapshot ideadoc = snapshot.data.documents[index];
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(ideadoc['pro_pic']),
                    ),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(ideadoc['username'], style: mystyle(20, Colors.black, FontWeight.w600),),
                        Text(
                          tAgo.format(ideadoc['time'].toDate()).toString(),
                          style: mystyle(14, Colors.grey, FontWeight.w500),
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(ideadoc['type'] == 1)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(ideadoc['idea'],
                                style: mystyle(20, Colors.black, FontWeight.w400),
                            ),
                          ),
                        if(ideadoc['type'] == 2)
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Image(image: NetworkImage(ideadoc['image']),),
                          ),
                        if(ideadoc['type'] == 3)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              children: [
                                Text(ideadoc['idea'],
                                  style: mystyle(20, Colors.black, FontWeight.w400),
                                ),
                                SizedBox(height: 20.0,),
                                Image(image: NetworkImage(ideadoc['image']),),
                              ],
                            )
                          ),
                        SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: ()=> likepost(ideadoc['id']),
                                  child: ideadoc['likes'].contains(_uid) ?
                                  Icon(Icons.favorite, color: Colors.red,)
                                  : Icon(Icons.favorite_border),
                                ),
                                SizedBox(width: 10,),
                                Text(ideadoc['likes'].length.toString(), style: mystyle(18),)
                              ],
                            ),
                            Row(
                              children: [
                                Text(ideadoc['count_comment'].toString(), style: mystyle(18),),
                                SizedBox(width: 10,),
                                InkWell(
                                  child: Icon(Icons.comment),
                                  onTap: ()=> Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>
                                          CommentPage(ideadoc['id']))
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(ideadoc['share_count'].toString(), style: mystyle(18),),
                                SizedBox(width: 10,),
                                InkWell(
                                  child: Icon(Icons.share),
                                  onTap: ()=> sharepost(ideadoc['id'], ideadoc['idea']),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              });
        }
      ),
    );
  }
}