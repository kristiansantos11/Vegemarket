import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:vegemarket/Model/itemData.dart';
import 'package:vegemarket/Model/userData.dart';
import 'package:vegemarket/Services/cloud_storage/CloudStorage.dart';

class Database
{
  Map<String, dynamic> userInfo;
  UploadTask result;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference basicInfo = FirebaseFirestore.instance.collection('Basic Info');

  Future registerUser(UserData user) async
  {
    try
    {
      await auth.createUserWithEmailAndPassword(email: user.email, password: user.password);
      User firebaseUser = FirebaseAuth.instance.currentUser;
      user.uid = firebaseUser.uid.toString();
      await CloudStorage().uploadProfilePicture(
        file: user.profilePicture,
        uid: user.uid,
        def: true,
      );
      user.profilePictureLink = await CloudStorage().getProfilePictureLink(uid: user.uid);
      await basicInfo.doc("${user.uid}").set(user.returnUserData());
      return null;
    }
    catch(e)
    {
      return(e.toString());
    }
  }

  Future registerItem(String ownerName, ItemData item) async
  {
    try
    {
      User user = FirebaseAuth.instance.currentUser;
      await CloudStorage().uploadItemPicture(
        file: File('assets/img/default_profile_picture.jpg'),
        uid: user.uid,
        name: item.name + "_" + ownerName,
        def: true,
      );
      item.itemPictureLink = await CloudStorage().getItemPictureLink(uid: user.uid, name: item.name + "_" + ownerName);
      await basicInfo.doc("${user.uid}").collection("items").doc(item.name + "_" + ownerName).set(item.returnItemData());
      return null;
    }
    catch(e)
    {
      return(e.toString());
    }
  }
}