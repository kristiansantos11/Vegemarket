import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vegemarket/Model/itemData.dart';
import 'package:vegemarket/Screens/ScreenArguments/ItemScreenArguments.dart';
import 'package:vegemarket/Screens/dialog/newPictureUploadDialog.dart';
import 'package:provider/provider.dart';
import 'package:vegemarket/Screens/add_item_screen.dart';
import 'package:vegemarket/Screens/items_screen.dart';
import 'package:vegemarket/Services/database/FetchItemList.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  static const routeName = "/profile";

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  Random rnd = new Random();
  List<Color> colors = [
    Colors.pink[50],
    Colors.lightGreenAccent[100],
    Colors.blue[50],
    Colors.purple[50],
    Colors.teal[50],
    Colors.indigo[100]
  ];

  @override
  Widget build(BuildContext context) {
    User user = context.watch<User>();
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Basic Info")
            .doc(user.uid)
            .snapshots(),
        builder: (context, snapshot) {
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: Color.fromARGB(255,190,246,247),
              ),
              child: (user == null)
                  ? Center(child: CircularProgressIndicator())
                  : StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("Basic Info") //
                          .doc(user.uid)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if ((snapshot == null) || (snapshot.data == null)) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Center(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                    gradient: LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color.fromARGB(225,75,196,197),
                                        Color.fromARGB(225,21,156,157)
                                      ],
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: InkWell(
                                          onTap: () {
                                            newProfilePictureDialog(
                                                context: context, user: user);
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            child: Container(
                                              width: 100,
                                              height: 100,
                                              child: FadeInImage.assetNetwork(
                                                placeholder:
                                                    'assets/img/default_profile_picture.jpg',
                                                image: snapshot
                                                    .data["profile_picture"],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          'Name: ' +
                                              snapshot.data["name"] +
                                              ' \n'
                                                  'Username: ' +
                                              snapshot.data["username"] +
                                              '\n'
                                                  'Contact No: ' +
                                              snapshot.data["contactNumber"],
                                          style: TextStyle(
                                            fontFamily: 'Proxima Nova',
                                            fontStyle: FontStyle.normal,
                                            fontSize: 18,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                child: StreamBuilder<List<ItemData>>(
                                    stream: ItemListGetter(user).itemListData,
                                    builder: (context, items) {
                                      if (items.data == null) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      }
                                      if (items.data.length != 0) {
                                        return GridView.builder(
                                          itemCount: items.data.length,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            crossAxisSpacing: 2.5,
                                            mainAxisSpacing: 2.5,
                                          ),
                                          itemBuilder: (content, index) {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.of(context).pushNamed(
                                                  ItemsScreen.routeName,
                                                  arguments:
                                                      ItemScreenArguments(
                                                    itemName: items
                                                        .data[index].itemName,
                                                    vendorUID: items
                                                        .data[index].vendorUID,
                                                    username: items
                                                        .data[index].username,
                                                    description: items
                                                        .data[index]
                                                        .description,
                                                  ),
                                                );
                                              },
                                              child: Center(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(15),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadiusDirectional
                                                                .circular(12),
                                                        color: colors[
                                                            rnd.nextInt(
                                                                colors.length)],
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color:
                                                                Colors.black45,
                                                            offset: Offset
                                                                .fromDirection(
                                                                    1, 7),
                                                            blurRadius: 5,
                                                            spreadRadius: 5,
                                                          ),
                                                        ]),
                                                    alignment: Alignment.center,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          child: Container(
                                                            width: 100,
                                                            height: 100,
                                                            child: FadeInImage
                                                                .assetNetwork(
                                                              placeholder:
                                                                  'assets/img/missing_item_icon.jpg',
                                                              image: items
                                                                  .data[index]
                                                                  .itemPictureLink,
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          items.data[index]
                                                              .itemName, //text
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Proxima Nova',
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            fontSize: 18,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                      return Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.white30,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: 50,
                                                  width: 300,
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors
                                                            .blueGrey[300],
                                                        spreadRadius: 5,
                                                        blurRadius: 8,
                                                        offset: Offset
                                                            .fromDirection(
                                                                1, 5),
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(40),
                                                    ),
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.blue[900],
                                                        Colors.blue[700]
                                                      ],
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'You haven\'t sold anything yet.',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Proxima Nova',
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                              ElevatedButton(
                                child: Text('Add Item'),
                                style: ButtonStyle(
                                  fixedSize: MaterialStateProperty.all(
                                      Size(200, 50)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(225,41,176,177)),
                                ),
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(AddItem.routeName);
                                },
                              ),
                            ],
                          ),
                        );
                      }),
            ),
          );
        });
  }
}
