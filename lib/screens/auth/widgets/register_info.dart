import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:invest_idea_app/config/palette.dart';
import 'package:invest_idea_app/config/variables.dart';
import 'package:invest_idea_app/screens/home.dart';
import 'dart:io';

class RegisterInfo extends StatefulWidget {
  const RegisterInfo({Key key}) : super(key: key);

  static MaterialPageRoute get route => MaterialPageRoute(
    builder: (context) => const RegisterInfo(),
  );

  @override
  _RegisterInfoState createState() => _RegisterInfoState();
}

class _RegisterInfoState extends State<RegisterInfo>
    with SingleTickerProviderStateMixin {
  int _gender = 1;
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

  storeUserInfo() async {
    setState(() {
      isUploading = true;
    });
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();

    if(imagepath == null){
      Firestore.instance.collection('users').document(user.uid)
          .setData({
        'username' : _username.text,
        'gender' : _gender,
        'profession' : _profession.text,
        'dob' : _dob.text,
        'uid' : user.uid,
        'pro_pic' : 'https://www.accountingweb.co.uk/sites/all/modules/custom/sm_pp_user_profile/img/default-user.png'
      });
    }
    else{
      String img_url = await uploadimage(user.uid);
      Firestore.instance.collection('users').document(user.uid)
          .setData({
        'username' : _username.text,
        'gender' : _gender,
        'profession' : _profession.text,
        'dob' : _dob.text,
        'uid' : user.uid,
        'pro_pic' : img_url
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.darkBlue,
      body: isUploading == false ? Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Enter Your \nInformation',
                     style: const TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 15,
                child: ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: TextFormField(
                        controller: _username,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Username',
                          prefixIcon: Icon(Icons.person_pin),
                        ),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Container(
                        padding: const EdgeInsets.only(left: 16.0, right: 10.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: _gender,
                            items: [
                              DropdownMenuItem(
                                child: Text('Male'),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: Text('Female'),
                                value: 2,
                              ),
                              DropdownMenuItem(
                                child: Text('Others'),
                                value: 3,
                              ),
                            ],
                            onChanged: (value){
                              setState(() {
                                _gender = value;
                              });
                            },
                            hint: Text('Select Gender'),
                          ),
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
                          hintText: 'Profession',
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
                            hintText: 'Date of Birth'
                          ),
                        ),
                      )
                    ),
                    imagepath == null ? Container()
                        : MediaQuery.of(context).viewInsets.bottom>0 ? Container()
                        : Image(
                      width: 100,
                      height: 100,
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
                                "Upload Profile Photo",
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
                          onTap: () => {
                            storeUserInfo(),
                            Navigator.of(context).pushReplacement(HomePage.route),
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
                                "Finish",
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
        child: Text('Finishing up...', style: mystyle(25, Colors.white),),
      )
    );
  }
}

