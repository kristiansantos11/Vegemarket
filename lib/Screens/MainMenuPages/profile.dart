import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vegemarket/Model/itemData.dart';
import 'package:vegemarket/Screens/dialog/newPictureUploadDialog.dart';
import 'package:provider/provider.dart';
import 'package:vegemarket/Screens/add_item_screen.dart';
import 'package:vegemarket/Services/database/FetchItemList.dart';

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
                                    'Contact No: ' + snapshot.data["contactNumber"],
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
                    child: StreamBuilder(
                      stream: ItemListGetter(user).itemListData,
                      builder: (ctx, items) {
                        if(items==null){
                          return Center(child: CircularProgressIndicator());
                        }
                        if(items.hasData){
                          return GridView.builder(
                            itemCount: items.data.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 15.0,
                              mainAxisSpacing: 15.0,
                            ),
                            itemBuilder: (content, index){
                              print(items.data[index].name);
                              return Text(items.data[index].name);
                            }
                          );
                        }
                        return Padding(
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
                                    height: 50,
                                    width: 300,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.blueGrey[300],
                                          spreadRadius: 5,
                                          blurRadius: 8,
                                          offset: Offset.fromDirection(1, 5),
                                        ),
                                      ],
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(40),
                                      ),
                                      gradient: LinearGradient(
                                        colors: [Colors.blue[900], Colors.blue[700]],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                     ),
                                    child: Text(
                                      'You haven\'t sold anything yet.',
                                      style: TextStyle(
                                        fontFamily: 'Proxima Nova',
                                        fontStyle: FontStyle.normal,
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
                      }
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0,0,10),
                    child: ElevatedButton(
                      child: Text('Add Item'),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(Colors.blue[900]),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(AddItem.routeName);
                      },
                    ),
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
