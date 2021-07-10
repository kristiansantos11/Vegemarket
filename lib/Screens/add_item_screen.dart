import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vegemarket/Model/itemData.dart';
import 'package:vegemarket/Screens/askItemPicture.dart';
import 'package:vegemarket/Services/database/Database.dart';
import 'package:provider/provider.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key key}) : super(key: key);

  static const routeName = '/add_item';

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  TextEditingController _itemNameController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    User user = context.watch<User>();
    if (user == null) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Basic Info")
            .doc(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          return Scaffold(
            //backgroundColor: Colors.grey[600],
            appBar: AppBar(
              toolbarHeight: 65,
              centerTitle: true,
              shadowColor: Colors.white,
              backgroundColor: Colors.white,
              title: Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height / 15,
                    maxWidth: MediaQuery.of(context).size.width / 2,
                  ),
                  child: Image.asset(
                    "assets/img/vegemarket-text.png",
                  ),
                ),
              ),
            ),
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SafeArea(
                      child: Container(
                        height: 500,
                        width: 500,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.blue[800], Colors.blueGrey[900]]),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(20),
                              child: TextFormField(
                                controller: _itemNameController,
                                decoration: InputDecoration(
                                  hintText: 'Item name',
                                  labelText: 'Item Name',
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(70),
                                    //topRight: Radius.circular(70),
                                    bottomLeft: Radius.circular(12),
                                    bottomRight: Radius.circular(12),
                                  ),
                                  color: Colors.white24,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(50),
                                  child: Container(
                                    //color: Colors.transparent,
                                    child: TextField(
                                      controller: _descriptionController,
                                      maxLength: 350,
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                        labelText: "Item Description",
                                        hintText: "Item Desription",
                                      ),
                                      selectionHeightStyle: BoxHeightStyle.max,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Back'),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                        ),
                        onPressed: () {
                          ItemData item = ItemData(
                            itemName: _itemNameController.text,
                            vendorUID: user.uid,
                            description: _descriptionController.text,
                            rating: [],
                            comment: [],
                            username: snapshot.data['username'],
                            itemPicture:
                                File('assets/img/missing_item_icon.jpg'),
                          );
                          Database()
                              .registerItem(snapshot.data['username'], item);
                          Navigator.of(context)
                              .pushNamed(AskItemPicture.routeName, arguments: {
                            "itemName": _itemNameController.text
                          });
                          _itemNameController.clear();
                          _descriptionController.clear();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 2),
                              content: Row(
                                children: [
                                  Icon(
                                    Icons.thumb_up_sharp,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Item added!',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: Text('Next'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
