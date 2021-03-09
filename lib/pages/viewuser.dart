import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:invest_idea_app/config/palette.dart';
import 'package:invest_idea_app/config/variables.dart';
import 'package:invest_idea_app/pages/comments.dart';
import 'package:timeago/timeago.dart' as tAgo;

class ViewUserPage extends StatefulWidget {
  final String uid;
  ViewUserPage(this.uid);
  @override
  _ViewUserPageState createState() => _ViewUserPageState();
}

class _ViewUserPageState extends State<ViewUserPage> {
  String _uid;
  Stream userstream;
  String username;
  String pro_pic;
  int following;
  int followers;
  bool isDataThere = false;
  bool isFollowing;
  initState() {
    super.initState();
    getcurrentuserid();
    getstream();
    getcurrentuserinfo();
  }

  getcurrentuserinfo() async{
    var user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot userdoc = await usercollection.document(widget.uid.trim()).get();
    var followersdocuments = await usercollection.document(widget.uid).collection('followers').getDocuments();
    var followingdocuments = await usercollection.document(widget.uid).collection('following').getDocuments();

    usercollection
        .document(widget.uid)
        .collection('followers')
        .document(user.uid)
        .get().then((document){
          if(document.exists){
            setState(() {
              isFollowing = true;
            });
          }else{
            setState(() {
              isFollowing = false;
            });
          }
        });

    setState(() {
      username = userdoc['username'];
      pro_pic = userdoc['pro_pic'];
      isDataThere = true;
      followers = followersdocuments.documents.length;
      following = followingdocuments.documents.length;
    });
  }

  getstream() async{
    setState(() {
      userstream = ideacollection.where('uid', isEqualTo: widget.uid.trim()).orderBy('time', descending: true).snapshots();
    });
  }

  getcurrentuserid() async{
    var user = await FirebaseAuth.instance.currentUser();
    setState(() {
      _uid = user.uid;
    });
  }

  followuser() async{
    var document = await usercollection.document(widget.uid).collection('followers').document(_uid).get();

    if(!document.exists){
      usercollection
          .document(widget.uid)
          .collection('followers')
          .document(_uid)
          .setData({});
      usercollection
          .document(_uid)
          .collection('following')
          .document(widget.uid)
          .setData({});

      setState(() {
        followers++;
        isFollowing = true;
      });
    }else{
      usercollection
          .document(widget.uid)
          .collection('followers')
          .document(_uid)
          .delete();

      usercollection.document(_uid)
          .collection('following')
          .document(widget.uid)
          .delete();

      setState(() {
        followers--;
        isFollowing = false;
      });
    }
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
        title: Text('View Profile'),
        centerTitle: true,
      ),
      backgroundColor: Palette.darkBlue,
      body: isDataThere == true ? SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/5,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Colors.teal, Colors.teal])
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height/10,
              ),
              child: CircleAvatar(
                radius: 64,
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(pro_pic),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height/3.3,
              ),
              child: Column(
                children: [
                  Text(username, style: mystyle(25, Colors.white, FontWeight.w600),),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text('Following', style: mystyle(20, Colors.white, FontWeight.w500),),
                      Text('Followers', style: mystyle(20, Colors.white, FontWeight.w500),),
                    ],
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(following.toString(), style: mystyle(20, Colors.white, FontWeight.w500),),
                      Text(followers.toString(), style: mystyle(20, Colors.white, FontWeight.w500),),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Center(
                    child: ButtonTheme(
                      minWidth: 160,
                      height: 45,
                      child: RaisedButton(
                        color: Colors.teal,
                        shape: StadiumBorder(),
                        child: Text(isFollowing == false ? 'Follow' : 'Unfollow', style: mystyle(22, Colors.black , FontWeight.w500)),
                        onPressed: ()=> followuser(),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  StreamBuilder(
                      stream: userstream,
                      builder: (context, snapshot) {
                        if(!snapshot.hasData){
                          return CircularProgressIndicator(backgroundColor: Palette.darkBlue,);
                        }
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
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
                                      ),
                                      SizedBox(height: 5,)
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                  ),
                ],
              ),
            )
          ],
        ),
      )
          : Center(
        child: CircularProgressIndicator(backgroundColor: Palette.darkBlue,),
      ),
    );
  }
}
