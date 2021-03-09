import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:invest_idea_app/config/palette.dart';
import 'package:invest_idea_app/config/variables.dart';

class PostIdeaPage extends StatefulWidget {
  @override
  _PostIdeaPageState createState() => _PostIdeaPageState();
}

class _PostIdeaPageState extends State<PostIdeaPage> {
  File imagepath;
  TextEditingController _ideacontroller = TextEditingController();
  bool isUploading = false;
  
  pickImage(ImageSource imgsrc) async{
    final image = await ImagePicker().getImage(source: imgsrc);
    setState(() {
      imagepath = File(image.path);
    });
    Navigator.pop(context);
  }
  optionDialog(){
    return showDialog(
        context: context,
      builder: (context){
          return SimpleDialog(
            children: [
              SimpleDialogOption(
                onPressed: ()=> pickImage(ImageSource.gallery),
                child: Text('Gallery', style: mystyle(20),),
              ),
              SimpleDialogOption(
                onPressed: ()=> pickImage(ImageSource.camera),
                child: Text('Camera', style: mystyle(20),),
              ),
              SimpleDialogOption(
                onPressed: ()=> Navigator.pop(context),
                child: Text('Cancel', style: mystyle(20),),
              ),
            ],
          );
      }
    );
  }

  uploadimage(String id) async{
    StorageUploadTask storageUploadTask = ideapictures.child(id).putFile(imagepath);
    StorageTaskSnapshot storageTaskSnapshot = await storageUploadTask.onComplete;
    String downloadurl = await storageTaskSnapshot.ref.getDownloadURL();
    return downloadurl;
  }

  postIdea() async{
    setState(() {
      isUploading = true;
    });
    var user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot userdoc = await usercollection.document(user.uid).get();
    var alldocuments =  await ideacollection.getDocuments();
    int length = alldocuments.documents.length;
    //only idea
    if(_ideacontroller.text != '' && imagepath == null){
      ideacollection.document('Idea $length').setData({
        'username' : userdoc['username'],
        'pro_pic' : userdoc['pro_pic'],
        'uid' : user.uid,
        'id': 'Idea $length',
        'idea': _ideacontroller.text,
        'likes' : [],
        'count_comment': 0,
        'share_count': 0,
        'type' : 1,
        'time' : DateTime.now()
      });
      Navigator.pop(context);
    }

    //only photo
    if(_ideacontroller.text == '' && imagepath != null){
      String img_url = await uploadimage('Idea $length');
      ideacollection.document('Idea $length').setData({
        'username' : userdoc['username'],
        'pro_pic' : userdoc['pro_pic'],
        'uid' : user.uid,
        'id': 'Idea $length',
        'image': img_url,
        'likes' : [],
        'count_comment': 0,
        'share_count': 0,
        'type' : 2
      });
      Navigator.pop(context);
    }
    //idea + photo
    if(_ideacontroller.text != '' && imagepath != null){
      String img_url = await uploadimage('Idea $length');
      ideacollection.document('Idea $length').setData({
        'username' : userdoc['username'],
        'pro_pic' : userdoc['pro_pic'],
        'uid' : user.uid,
        'id': 'Idea $length',
        'idea' : _ideacontroller.text,
        'image': img_url,
        'likes' : [],
        'count_comment': 0,
        'share_count': 0,
        'type' : 3,
        'time' : DateTime.now()
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Idea'),
        backgroundColor: Palette.darkBlue,
        centerTitle: true,
      ),
      body: isUploading == false ? Column(
        children: [
          Expanded(
            child: TextField(
              controller: _ideacontroller,
              maxLines: null,
              style: mystyle(20),
              decoration: InputDecoration(
                hintText: 'Got a new idea?',
                labelStyle: mystyle(25),
                contentPadding: EdgeInsets.all(15.0),
                border: InputBorder.none,
              ),
            ),
          ),
          imagepath == null ? Container()
              : MediaQuery.of(context).viewInsets.bottom>0 ? Container()
              : Image(
            width: 200,
            height: 200,
            image: FileImage(imagepath),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 160, right: 10, bottom: 20),
            child: Row(
              children: [
                RawMaterialButton(
                  fillColor: Palette.darkBlue,
                  shape: StadiumBorder(),
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.add_a_photo, color: Colors.white,),
                  onPressed: ()=> optionDialog(),
                ),
                SizedBox(width: 30,),
                RawMaterialButton(
                  fillColor: Palette.darkBlue,
                  shape: StadiumBorder(),
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Post', style: mystyle(20, Colors.white)),
                  onPressed: ()=> postIdea(),
                ),
              ],
            ),
          )
        ],
      )
      : Center(
        child: Text('Posting...', style: mystyle(25),),
    )
    );
  }
}