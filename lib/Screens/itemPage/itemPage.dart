import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ItemPage extends StatefulWidget {
  const ItemPage({ Key key }) : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  String username;
  String itemName;
  String vendorUID;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
                              .collection("Basic Info")
                              .doc(vendorUID)
                              .collection("items")
                              .doc(itemName+"_"+username)
                              .snapshots(),
      builder: (context, snapshot) {
        return Scaffold(
          
        );
      }
    );
  }
}