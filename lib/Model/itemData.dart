import 'dart:io';
import 'package:meta/meta.dart';

class ItemData{
  String itemName;
  String username;
  String description;
  List<int> rating = [];
  List<String> comment = [];
  File itemPicture;
  String itemPictureLink;
  String vendorUID;

  ItemData({
    @required this.itemName,
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
      'itemName' : this.itemName,
      'username' : this.username,
      'vendorUID' : this.vendorUID,
      'description' : this.description,
      'rating' : this.rating,
      'comment' : this.comment,
      'itemPictureLink' : this.itemPictureLink
    };
  }
}