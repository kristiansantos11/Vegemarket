import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:vegemarket/Model/userData.dart';
import 'package:vegemarket/Screens/dialog/newPictureUploadDialog.dart';
import 'package:vegemarket/Services/AuthenticationService.dart';
import 'package:provider/provider.dart';
import 'package:vegemarket/Screens/add_item_screen.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    User user = context.watch<User>();
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          //color: Colors.red[300],
          color: Colors.yellow[300],
        ),
        child: (user==null) ? 
        Center(child: CircularProgressIndicator()) : 
        StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Basic Info").doc(user.uid).snapshots(),
          builder: (context, snapshot) {
            if((snapshot==null)||(snapshot.data==null)){
              return Center(child: CircularProgressIndicator(),);
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
                          begin: Alignment.topCenter,
                          end: Alignment.bottomRight,
                          colors: [Colors.blue.shade900, Colors.blue[800]],
                        ),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: InkWell(
                              onTap: (){
                                newProfilePictureDialog(context: context, user: user);
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/img/default_profile_picture.jpg',
                                    image: snapshot.data["profile_picture"],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text('Name: ' + snapshot.data["name"] +
                                ' \n'
                                    'Username: ' + snapshot.data["username"] + 
                                '\n'
                                    'Contact No: ' + snapshot.data["contactNumber"]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white30,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Container(
                              alignment: Alignment.center,
                              height: 450,
                              width: 200,
                              child: Text(
                                'You haven\'t sold anything yet. \n inaaral ko pa yung pag integrate ng firebase sorry :)',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    child: Text('Add Item'),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue[900]),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(AddItem.routeName);
                    },
                  ),
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
