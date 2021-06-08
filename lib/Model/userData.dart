import 'dart:io';

class UserData{
  String? email;
  String? uid;
  String? name;
  String? username;
  DateTime? birthdate;
  String? password;
  String? contactNumber;
  File? profilePicture;
  String? profilePictureLink;

  UserData({
    required this.email,
    this.uid,
    required this.name,
    required this.username,
    required this.birthdate,
    required this.password,
    required this.contactNumber,
    this.profilePicture,
    this.profilePictureLink,
  });

  Map<String, dynamic> returnUserData(){
    return {
      'email' : this.email,
      'uid' : this.uid,
      'name' : this.name,
      'username' : this.username,
      'birthdate' : this.birthdate,
      'password' : this.password,
      'contactNumber' : this.contactNumber,
      'profile_picture' : this.profilePictureLink,
    };
  }
}