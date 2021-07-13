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
      return Scaffold(
        body: CircularProgressIndicator(),
      );
    }
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('Basic Info')
          .doc(user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          extendBodyBehindAppBar: true,
          // appBar: AppBar(
          //   toolbarHeight: 65,
          //   centerTitle: true,
          //   shadowColor: Colors.white,
          //   backgroundColor: Colors.white,
          //   title: Padding(
          //     padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          //     child: ConstrainedBox(
          //       constraints: BoxConstraints(
          //         maxHeight: MediaQuery.of(context).size.height / 15,
          //         maxWidth: MediaQuery.of(context).size.width / 2,
          //       ),
          //       child: Image.asset(
          //         "assets/img/vegemarket-text.png",
          //       ),
          //     ),
          //   ),
          // ),
          // resizeToAvoidBottomInset: false,
          body: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 270,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)),
                    gradient: LinearGradient(
                      //colors: [Colors.blue[900], Colors.grey[900]],
                      colors: [Colors.deepPurple[700], Colors.grey[900]],
                      //colors: [Colors.purpleAccent, Colors.redAccent],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: ClipRRect(
                            clipBehavior: Clip.antiAlias,
                            borderRadius: BorderRadius.circular(12),
                            child: Container(
                              width: 250,
                              height: 200,
                              //color: Colors.teal,
                              child: Image.asset(
                                'assets/img/LOGO-trans.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0,0,0,20),
                          child: Text(
                            'ADD ITEM',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Proxima Nova',
                              fontSize: 24,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: ListView(
                    children: [
                      SizedBox(height: 40),
                      Container(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    'Item Name',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'BalsamiqSans',
                                      fontSize: 24,
                                      // color: Colors.white,
                                      // backgroundColor: Colors.deepPurple[700],
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        controller: _itemNameController,
                                        decoration: InputDecoration(
                                          hintText: 'Item Name',
                                          labelText: 'Item Name',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 60),
                              Column(
                                children: [
                                  Text(
                                    'Item Description',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'BalsamiqSans',
                                      fontSize: 24,
                                      // color: Colors.white,
                                      // backgroundColor: Colors.deepPurple[700],
                                    ),
                                  ),
                                  Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: TextField(
                                          controller: _descriptionController,
                                          maxLength: 1000,
                                          maxLines: 5,
                                          decoration: InputDecoration(
                                            labelText: "Item Description",
                                            hintText: "Item Desription",
                                            border: OutlineInputBorder(),
                                          ),
                                          selectionHeightStyle:
                                              BoxHeightStyle.max),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),

                      
                    ],
                  ),
                ),
                  
                

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
      },
    );
  }
}
