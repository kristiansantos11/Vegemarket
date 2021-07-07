import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class ImageUtils {
  static Future<File> imageToFile({String imageName, String ext}) async {
    var bytes = await rootBundle.load('assets/img/$imageName.$ext');
    String tempPath = (await getTemporaryDirectory()).path;
    File file = File('$tempPath/profile.png');
    await file.writeAsBytes(
        bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
    return file;
  }
}

class CloudStorage{
  Future<void> uploadProfilePicture({File file, @required String uid, bool def = false}) async {
    if(def){
      file = await ImageUtils.imageToFile(imageName: 'default_profile_picture', ext: 'jpg');
    }

    if (!def && file == null) {
      print("No file was selected. Ignoring method.");
      return null;
    }

    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profile')
        .child(uid)
        .child('/profile_picture.jpg');

    print("Reference created.");

    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    if (kIsWeb) {
      await ref.putData(await file.readAsBytes(), metadata);
    } else {
      print("Path temporarily stored at: ${file.path}");
      await ref.putFile(file, metadata);
      print("Upload Done.");
      await getProfilePictureLink(uid: uid).then(
        (String link) async {
          if(!def){
            await FirebaseFirestore.instance
                                   .collection('Basic Info')
                                   .doc(uid)
                                   .set({'profile_picture' : link}, SetOptions(merge: true));
          }
        }
      );
    }
  }

  Future<void> uploadItemPicture({File file, @required String uid, @required String name, bool def = false}) async {
    if(def){
      file = await ImageUtils.imageToFile(imageName: 'default_profile_picture', ext: 'jpg');
    }

    if (!def && file == null) {
      print("No file was selected. Ignoring method.");
      return null;
    }

    // Create a Reference to the file
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profile')
        .child(uid)
        .child(name)
        .child('/item_picture.jpg');

    print("Reference created.");

    final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path});

    if (kIsWeb) {
      await ref.putData(await file.readAsBytes(), metadata);
    } else {
      print("Path temporarily stored at: ${file.path}");
      await ref.putFile(file, metadata);
      print("Upload Done.");
      await getItemPictureLink(uid: uid, name: name).then(
        (String link) async {
          if(!def){
            await FirebaseFirestore.instance
                                   .collection('Basic Info')
                                   .doc(uid)
                                   .collection("items")
                                   .doc(name)
                                   .set({'itemPictureLink' : link}, SetOptions(merge: true));
          }
        }
      );
    }
  }

  Future<String> getProfilePictureLink({@required String uid}) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profile')
        .child(uid)
        .child('/profile_picture.jpg');
    
    return ref.getDownloadURL();
  }

  Future<String> getItemPictureLink({@required String uid, @required String name}) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('profile')
        .child(uid)
        .child(name)
        .child('/item_picture.jpg');
    
    return ref.getDownloadURL();
  }

}