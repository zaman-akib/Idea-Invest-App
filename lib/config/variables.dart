import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle mystyle(double size, [Color color, FontWeight fw]) {
  return GoogleFonts.montserrat(
    fontSize: size,
    color: color,
    fontWeight: fw,
  );
}

CollectionReference usercollection = Firestore.instance.collection('users');
CollectionReference ideacollection = Firestore.instance.collection('ideas');
StorageReference ideapictures = FirebaseStorage.instance.ref().child('idea_pictures');
StorageReference userpictures = FirebaseStorage.instance.ref().child('user_pictures');
var exampleImage = 'https://www.accountingweb.co.uk/sites/all/modules/custom/sm_pp_user_profile/img/default-user.png';

