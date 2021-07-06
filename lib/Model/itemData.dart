import 'dart:io';
import 'package:meta/meta.dart';

class ItemData{
  String name;
  String description;
  List<int> rating;
  List<String> comment;
  File itemPicture;
  String itemPictureLink;

  ItemData({
    @required this.name,
    @required this.description,
    this.itemPicture,
    this.itemPictureLink,
    this.rating,
    this.comment
  });

  Map<String, dynamic> returnItemData(){
    return {
      'name' : this.name,
      'description' : this.description,
      'rating' : this.rating,
      'comment' : this.comment,
      'itemPictureLink' : this.itemPictureLink
    };
  }
}