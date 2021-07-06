import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Search results"),
        backgroundColor: Colors.amber[800],
      ),
      body: SafeArea(
        child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Text("Test")),
              ],
            ),

      ),
    );
  }
}