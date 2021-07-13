import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegemarket/Model/itemData.dart';

/*Continue working on item_screen, profile,
and please improve the add_item_screen

*note ko to sa sarili ko
-Mark Baguio*/

/*note/s:
-ikaw na bahala sa kulay/gradient

New Task:
-add add to cart button on items_screen
-itemName fontcolor => white

*/
class ItemsScreen extends StatefulWidget {
  final itemName;
  final vendorUID;
  final username;
  final description;

  const ItemsScreen({
    Key key,
    this.itemName,
    this.vendorUID,
    this.username,
    this.description,
  }) : super(key: key);

  static const routeName = '/items_screen';

  @override
  _ItemsScreenState createState() => _ItemsScreenState(
      itemName: itemName,
      vendorUID: vendorUID,
      username: username,
      description: description);
}

class _ItemsScreenState extends State<ItemsScreen> {
  String itemName;
  String vendorUID;
  String username;
  String description;
  _ItemsScreenState(
      {this.itemName, this.vendorUID, this.username, this.description});
  @override
  Widget build(BuildContext context) {
    User currentUser = context.watch<User>();
    if (currentUser == null) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
    try {
      return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Basic Info')
            .doc(vendorUID)
            .snapshots(),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(color: Colors.black),
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
            body: Center(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Basic Info')
                    .doc(vendorUID)
                    .collection('items')
                    .doc(itemName + '_' + username)
                    .snapshots(),
                builder: (context, item) {
                  if ((item == null) || (item.data == null)) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Column(
                    children: [
                      Flexible(
                        flex: 2,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          decoration: BoxDecoration(
                            //borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              //colors: [Colors.red[900], Colors.redAccent],
                              //colors: [Colors.redAccent, Colors.pinkAccent],
                              //colors: [Colors.blue, Colors.indigo[900]],
                              colors: [Colors.redAccent, Colors.indigo],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Container(
                                      width: 200,
                                      height: 150,
                                      child: FadeInImage.assetNetwork(
                                        placeholder:
                                            'assets/img/missing_item_icon.jpg',
                                        image: item.data['itemPictureLink'],
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    item.data['itemName'],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontFamily: 'Proxima Nova',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          decoration: BoxDecoration(
                              //borderRadius: BorderRadius.circular(12),
                              //color: Colors.grey[400],
                              // border: Border.all(
                              //   width: 2,
                              //   style: BorderStyle.solid,
                              // ),
                              ),
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          30, 60, 0, 0),
                                      child: Text(
                                        'ITEM DESCRIPTION:',
                                        style: TextStyle(
                                          backgroundColor:
                                              Colors.redAccent[100],
                                          fontSize: 26,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 15, 30, 15),
                                  child: Container(
                                    color: Colors.grey[200],
                                    child: Text(
                                      item.data['description'],
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontFamily: 'Proxima Nova',
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0,0,20,0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                                    ),
                                  ),
                                  fixedSize: MaterialStateProperty.all(Size(150, 50)),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black38),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('Back'),
                              ),
                            ),
                            (vendorUID != currentUser.uid) ? ElevatedButton(
                              style: ButtonStyle(
                                fixedSize: MaterialStateProperty.all(Size(150, 50)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                                  ),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.blue),
                              ),
                              onPressed: () async {
                                ItemData insertedItem = ItemData(
                                  username: item.data['username'],
                                  vendorUID: item.data['vendorUID'],
                                  itemName: item.data['itemName'],
                                  description: item.data['description'],
                                  itemPictureLink: item.data['itemPictureLink'],
                                );
                                FirebaseFirestore.instance
                                    .collection("Basic Info")
                                    .doc(currentUser.uid)
                                    .collection("cart")
                                    .doc(itemName + "_" + username)
                                    .set(insertedItem.returnItemData());
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: Duration(seconds: 2),
                                    content: Row(
                                      children: [
                                        Icon(
                                          Icons.check_circle_outline_outlined,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: Text(
                                            'Item inserted!',
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                                Navigator.of(context).pop();
                              },
                              child: Text('Add To Cart'),
                            ) : SizedBox.shrink(),
                            (vendorUID == currentUser.uid) ? Padding(
                              padding: const EdgeInsets.fromLTRB(0,0,0,0),
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all(Size(150, 50)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red[500]),
                                ),
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: Duration(seconds: 2),
                                      content: Row(
                                        children: [
                                          Icon(
                                            Icons.check_circle_outline_outlined,
                                            color: Colors.white,
                                          ),
                                          SizedBox(
                                            width: 15,
                                          ),
                                          Expanded(
                                            child: Text(
                                              'Item deleted!',
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                  Future.delayed(
                                    Duration(milliseconds: 1000),
                                    () {
                                      FirebaseFirestore.instance
                                          .collection('Basic Info')
                                          .doc(vendorUID)
                                          .collection('items')
                                          .doc(itemName + '_' + username)
                                          .delete();
                                    },
                                  );
                                },
                                child: Text('Delete'),
                              ),
                            ) : SizedBox.shrink(),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      );
    } catch (e) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }
  }
}
