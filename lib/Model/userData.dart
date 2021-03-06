// The isSeller boolean variable is a band-aid solution
// to the Seller problem.

import 'dart:io';
import 'package:meta/meta.dart';

class UserData{
  String uid;
  String name;
  String email;
  String password;
  String username;
  DateTime birthdate;
  String contactNumber;
  File profilePicture;
  String profilePictureLink;
  String houseStreetAddress;
  String barangay;
  String city;
  String province;
  int isSeller;

  UserData({
    this.uid,
    this.email,
    this.password,
    @required this.name,
    @required this.username,
    this.birthdate,
    @required this.contactNumber,
    this.houseStreetAddress,
    this.barangay,
    this.city,
    this.province,
    this.profilePicture,
    this.profilePictureLink,
    this.isSeller,
  });

  Map<String, dynamic> returnUserData(){
    return {
      'uid' : this.uid.trim(),
      'name' : this.name.trim(),
      'username' : this.username.trim(),
      'birthdate' : this.birthdate,
      'contactNumber' : this.contactNumber.trim(),
      'houseStreetAddress' : this.houseStreetAddress.trim(),
      'barangay' : this.barangay.trim(),
      'province' : this.province.trim(),
      'city' : this.city.trim(),
      'profile_picture' : this.profilePictureLink.trim(),
      'isSeller' : this.isSeller,
    };
  }
}