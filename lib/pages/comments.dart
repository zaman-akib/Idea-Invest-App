import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:invest_idea_app/config/palette.dart';
import 'package:invest_idea_app/config/variables.dart';
import 'package:timeago/timeago.dart' as tAgo;

class CommentPage extends StatefulWidget {
  final String documentid;
  CommentPage(this.documentid);
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  var _commentcontroller = TextEditingController();

  addcomment() async{
    var user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot userdoc = await usercollection.document(user.uid).get();
    ideacollection.document(widget.documentid).collection('comments').document().setData({
      'comment' : _commentcontroller.text,
      'username' : userdoc['username'],
      'uid' : userdoc['uid'],
      'pro_pic' : userdoc['pro_pic'],
      'time' : DateTime.now()
    });
    DocumentSnapshot commentCount = await ideacollection.document(widget.documentid).get();
    ideacollection.document(widget.documentid).updateData({
      'count_comment' : commentCount['count_comment'] + 1,
    });
    _commentcontroller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 90,
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: ideacollection.document(widget.documentid).collection('comments').snapshots(),
                  builder: (context, snapshot) {
                    if(!snapshot.hasData){
                      return Center(child: CircularProgressIndicator());
                    }
                    return ListView.builder(
                      itemCount: snapshot.data.documents.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot commentdoc = snapshot.data.documents[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(commentdoc['pro_pic']),
                          ),
                          title: Text(commentdoc['username'], style: mystyle(20, Colors.black, FontWeight.w600),),
                          subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 3.0),
                                    child: Text(commentdoc['comment'],
                                      style: mystyle(17, Colors.black, FontWeight.w400),
                                    ),
                                  ),
                                ),
                                Align(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    //color: Colors.grey,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 2.0),
                                      child: Text(
                                        tAgo.format(commentdoc['time'].toDate()).toString(),
                                        style: mystyle(14, Colors.black, FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                ),
                              ]
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Divider(),
              ListTile(
                title: TextFormField(
                  controller: _commentcontroller,
                  decoration: InputDecoration(
                    hintText: 'Write a comment here...',
                    hintStyle: mystyle(18),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)
                    )
                  ),
                ),
                trailing: InkWell(
                  onTap: () => addcomment(),
                  child: Icon(Icons.send, color: Palette.darkBlue,),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
