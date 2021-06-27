import 'package:flutter/material.dart';

class VendorSearchResults extends StatefulWidget {
  const VendorSearchResults({ Key key }) : super(key: key);

  @override
  _VendorSearchResultsState createState() => _VendorSearchResultsState();
}

class _VendorSearchResultsState extends State<VendorSearchResults> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search results"),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.green[600],
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Text("hello"),
      ),
    );
  }
}