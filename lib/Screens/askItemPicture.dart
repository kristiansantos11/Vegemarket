import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:vegemarket/Screens/add_item_screen.dart';
import 'package:vegemarket/Screens/dialog/newPictureUploadDialog.dart';
import 'package:vegemarket/Screens/initial_screen.dart';


// TODO: Screen arguments for item name
class AskItemPicture extends StatefulWidget {
  const AskItemPicture({ Key key }) : super(key: key);

  static const routeName = '/askItemPicture';

  @override
  _AskItemPictureState createState() => _AskItemPictureState();
}

class _AskItemPictureState extends State<AskItemPicture> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Basic Info").doc(firebaseUser.uid).snapshots(),
      builder: (context, snapshot) {
        if((snapshot==null)||(snapshot.data==null)){
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        return Scaffold(
          body: Stack(
            children: <Widget>[

              Container(
                color: Colors.white,
              ),

              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Add a picture of your item!",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Proxima Nova',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700,
                              fontSize: 45,
                            ),
                          ),

                          SizedBox(
                            height: 15,
                          ),

                          Text(
                            //"It can be your real face or a representation of you, so people can uniquely identify you visually!",
                            "GULAY",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Proxima Nova',
                              fontStyle: FontStyle.normal,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),

                      GestureDetector(
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(color: Colors.black, width: 2.0),
                          ),
                          child: Center(
                            child: Icon(Icons.add, size: 48)
                          ),
                        ),
                        onTap: (){
                          // TODO: Sample lang yung sa itemName
                          newItemPictureDialog(context: context,
                                              user: firebaseUser,
                                              itemName: "eggplant_" + snapshot.data["username"]
                                              );
                        }
                      ),

                      ElevatedButton(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(20, 15, 20, 15)),
                          backgroundColor: MaterialStateProperty.all(Colors.green[600]),
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)))
                        ),
                        child: Text(
                          "LATER",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Proxima Nova',
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                          ),
                        ),
                        onPressed: (){
                          Navigator.of(context).popUntil(ModalRoute.withName(AddItem.routeName));
                        },
                      ),

                    ],
                  ),
                ),
              ),

            ],
          ),
        );
      }
    );
  }
}