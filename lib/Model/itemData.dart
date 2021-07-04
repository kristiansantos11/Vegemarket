import 'dart:io';
import 'package:meta/meta.dart';

class ItemData{
  String storeUID;
  String name;
  String storeName;
  String description;
  int rating;
  String comment;
  File itemPicture;
  String itemPictureLink;

  ItemData({
    @required this.storeUID,
    @required this.name,
    @required this.storeName,
    @required this.description,
    this.itemPicture,
    this.itemPictureLink,
    this.rating,
    this.comment
  });

  Map<String, dynamic> returnItemData(){
    return {
      'storeUID' : this.storeUID,
      'name' : this.name,
      'storeName' : this.storeName,
      'description' : this.description,
      'rating' : this.rating,
      'comment' : this.comment,
      'itemPictureLink' : this.itemPictureLink
    };
  }
}