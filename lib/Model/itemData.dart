import 'dart:io';
import 'package:meta/meta.dart';

class ItemData{
  String name;
  String username;
  String description;
  List<int> rating = [];
  List<String> comment = [];
  File itemPicture;
  String itemPictureLink;
  String vendorUID;

  ItemData({
    @required this.name,
    @required this.description,
    @required this.username,
    @required this.vendorUID,
    this.itemPicture,
    this.itemPictureLink,
    this.rating,
    this.comment
  });

  Map<String, dynamic> returnItemData(){
    return {
      'name' : this.name,
      'username' : this.username,
      'vendorUID' : this.vendorUID,
      'description' : this.description,
      'rating' : this.rating,
      'comment' : this.comment,
      'itemPictureLink' : this.itemPictureLink
    };
  }
}