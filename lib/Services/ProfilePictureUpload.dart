import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vegemarket/Screens/initial_screen.dart';
import 'package:vegemarket/Services/cloud_storage/CloudStorage.dart';

Future<File> onAlbumPick({@required ImagePicker imagePicker, 
                          @required BuildContext context,
                          }) async {
  User user = FirebaseAuth.instance.currentUser;
  File image;
  await imagePicker.getImage(source: ImageSource.gallery).then((_image){
      image = File(_image.path);
  }).then((_) async {
    await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop Profile Picture',
          toolbarColor: Colors.pink,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true),
      iosUiSettings: IOSUiSettings(
        title: 'Crop Profile Picture',
      )).then((File croppedImage) async {
        if (croppedImage != null) {
          image = croppedImage;
          await CloudStorage().uploadProfilePicture(file: image, uid: user.uid);
          Navigator.of(context).popUntil(ModalRoute.withName(InitialScreen.routeName));
        }
      });
  }).catchError((error){
    print("Cancelled.");
  });

  return image;
}

Future<File> onCameraPick({@required ImagePicker imagePicker,
                          @required BuildContext context,
                          }) async {
  User user = FirebaseAuth.instance.currentUser;
  File image;
  await imagePicker.getImage(source: ImageSource.camera).then((_image){
    image = File(_image.path);
  }).then((_) async {
    await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [CropAspectRatioPreset.square],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Crop Profile Picture',
          toolbarColor: Colors.pink,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: true),
      iosUiSettings: IOSUiSettings(
        title: 'Crop Profile Picture',
      )).then((File croppedImage) async {
        if (croppedImage != null) {
          image = croppedImage;
          await CloudStorage().uploadProfilePicture(file: image, uid: user.uid);
          Navigator.of(context).popUntil(ModalRoute.withName(InitialScreen.routeName));
        }
      });
  }).catchError((error){
    print("Cancelled.");
  });
  
  return image;
}