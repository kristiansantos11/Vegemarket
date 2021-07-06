import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vegemarket/Model/userData.dart';
import 'package:vegemarket/Screens/vendor_page/vendorPage.dart';
import 'package:vegemarket/Services/database/FetchShopSearchList.dart';
import 'package:provider/provider.dart';

import 'ScreenArguments/VendorScreenArguments.dart';

class VendorSearchResults extends StatefulWidget {
  final String nameSearch;
  const VendorSearchResults({ Key key, this.nameSearch}) : super(key: key);

  static const routeName = "/search_results";

  @override
  _VendorSearchResultsState createState() => _VendorSearchResultsState(nameSearch: this.nameSearch);
}

class _VendorSearchResultsState extends State<VendorSearchResults> {
  String nameSearch;
  _VendorSearchResultsState({this.nameSearch});


  @override
  Widget build(BuildContext context) {
    User user = context.watch<User>();
    if(user == null){
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Search results"),
        backgroundColor: Colors.amber[800],
      ),
      body: SafeArea(
        child:StreamBuilder<List<UserData>>(
          stream: SellerListSearchGetter(nameSearch).sellerListSearchData,
          builder: (context, snapshot) {
            if((snapshot==null)||snapshot.data==null){
              return Center(child: CircularProgressIndicator());
            }
            return Container(
              color: Colors.white,
                  child: GridView.builder(
                    padding: EdgeInsets.all(12),
                    // Checks if snapshot.data is null,
                    // if yes then set itemCount to 0 
                    // else set itemCount to length
                    itemCount: (snapshot.data == null) ? 0 : snapshot.data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 15.0,
                    ),
                    itemBuilder: (context, index) {
                      if(snapshot.data[index].uid == user.uid){
                        return SizedBox.shrink();
                      }
                      return InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamed(
                            VendorPage.routeName, 
                            arguments: VendorScreenArguments(
                              uid: snapshot.data[index].uid,
                              name: snapshot.data[index].name,
                            )
                          );
                        },
                        child: Center(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.amber[700],
                            ),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    child: FadeInImage.assetNetwork(
                                      placeholder: 'assets/img/default_profile_picture.jpg',
                                      image: snapshot.data[index].profilePictureLink,
                                    ),
                                  ),
                                ),
                                Text(
                                  snapshot.data[index].username,
                                  style: TextStyle(
                                    fontFamily: "Proxima Nova",
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );

                    },
                  ),
                );
          }
        ),

      ),
    );
  }
}