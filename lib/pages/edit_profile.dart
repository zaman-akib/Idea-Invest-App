import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:invest_idea_app/config/palette.dart';
import 'package:invest_idea_app/config/variables.dart';
import 'dart:io';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final format = DateFormat("dd-MM-yyyy");
  TextEditingController _username = TextEditingController();
  TextEditingController _profession = TextEditingController();
  TextEditingController _dob = TextEditingController();
  File imagepath;
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
    StorageUploadTask storageUploadTask = userpictures.child(id).putFile(imagepath);
    StorageTaskSnapshot storageTaskSnapshot = await storageUploadTask.onComplete;
    String downloadurl = await storageTaskSnapshot.ref.getDownloadURL();
    return downloadurl;
  }

  updateProfile() async{
    setState(() {
      isUploading = true;
    });
    var user = await FirebaseAuth.instance.currentUser();
    DocumentSnapshot userdoc = await usercollection.document(user.uid).get();

    if(_username.text != ''){
      usercollection.document(user.uid).updateData({
        'username': _username.text
      });
    }
    if(_profession.text != ''){
      usercollection.document(user.uid).updateData({
        'profession': _username.text
      });
    }
    if(_dob.text != ''){
      usercollection.document(user.uid).updateData({
        'dob': _username.text
      });
    }
    if(imagepath != null){
      String img_url = await uploadimage(user.uid);
      usercollection.document(user.uid).updateData({
        'pro_pic': img_url
      });
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
      ),
      backgroundColor: Palette.darkBlue,
        body: isUploading == false ? Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 6,
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: TextFormField(
                          controller: _username,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Change Username',
                            prefixIcon: Icon(Icons.person_pin),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: TextFormField(
                          controller: _profession,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Change Profession',
                            prefixIcon: Icon(Icons.work),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child : Container(
                            child: DateTimeField(
                              controller: _dob,
                              format: format,
                              onShowPicker: (context, currentValue){
                                return showDatePicker(
                                  context: context,
                                  initialDate: currentValue?? DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2100),
                                );
                              },
                              decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  prefixIcon: Icon(Icons.calendar_today),
                                  hintText: ' Change Date of Birth'
                              ),
                            ),
                          )
                      ),
                      imagepath == null ? Container()
                          : MediaQuery.of(context).viewInsets.bottom>0 ? Container()
                          : Image(
                        width: 200,
                        height: 200,
                        image: FileImage(imagepath),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child:Builder(
                          builder: (context) => InkWell(
                            onTap: () => optionDialog(),
                            focusColor: Colors.white,
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Palette.orange
                              ),
                              child: Center(
                                child: Text(
                                  "Update Profile Photo",
                                  style: mystyle(22, Palette.darkBlue, FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child:Builder(
                          builder: (context) => InkWell(
                            onTap: () => updateProfile(),
                            focusColor: Colors.white,
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Palette.orange
                              ),
                              child: Center(
                                child: Text(
                                  "Finish Update",
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
        ) : Center(
          child: Text('Updating Profile...', style: mystyle(25, Colors.white),),
        )
    );
  }
}
