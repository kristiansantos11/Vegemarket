import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vegemarket/Model/userData.dart';
import 'package:vegemarket/Services/cloud_storage/CloudStorage.dart';

class Database
{
  Map<String, dynamic>? userInfo;
  UploadTask? result;
  User? firebaseUser = FirebaseAuth.instance.currentUser;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference basicInfo = FirebaseFirestore.instance.collection('Basic Info');

  Future register(UserData user) async
  {
    try
    {
      await auth.createUserWithEmailAndPassword(email: user.email!, password: user.password!);
      user.uid = firebaseUser?.uid.toString();
      await CloudStorage().uploadProfilePicture(
        file: user.profilePicture,
        uid: user.uid!,
        def: true,
      );
      user.profilePictureLink = await CloudStorage().getProfilePictureLink(uid: user.uid!);
      await basicInfo.doc("${user.uid}").set(user.returnUserData());
      return null;
    }
    catch(e)
    {
      return(e.toString());
    }
  }
}