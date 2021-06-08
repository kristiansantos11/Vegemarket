import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:vegemarket/Screens/dialog/newProfilePictureDialog.dart';
import 'package:vegemarket/Screens/initial_screen.dart';

class AskProfilePicture extends StatefulWidget {
  static const routeName = '/askProfilePicture';
  @override
  _AskProfilePictureState createState() => _AskProfilePictureState();
}

class _AskProfilePictureState extends State<AskProfilePicture> {

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
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
                        "Add a profile picture!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Proxima Nova',
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700,
                          fontSize: 12,
                        ),
                      ),

                      SizedBox(
                        height: 15,
                      ),

                      Text(
                        "It can be your real face or a representation of you, so people can uniquely identify you visually!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Proxima Nova',
                          fontStyle: FontStyle.normal,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  GestureDetector(
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(color: Colors.black, width: 2.0),
                      ),
                      child: Center(
                        child: Icon(Icons.add, size: 12)
                      ),
                    ),
                    onTap: (){
                      newProfilePictureDialog(context: context, user: firebaseUser);
                    }
                  ),

                  ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.all(10.0)),
                      backgroundColor: MaterialStateProperty.all(Colors.green[600]),
                    ),
                    child: Text(
                      "LATER",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Proxima Nova',
                        fontStyle: FontStyle.normal,
                        fontSize: 15,
                      ),
                    ),
                    onPressed: (){
                      Navigator.of(context).popUntil(ModalRoute.withName(InitialScreen.routeName));
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
}