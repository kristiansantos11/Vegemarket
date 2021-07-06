import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class VendorPage extends StatefulWidget {
  static const routeName = '/vendor_page';

  final uid;
  final name;

  const VendorPage({ Key key, this.uid, this.name }) : super(key: key);

  @override
  _VendorPageState createState() => _VendorPageState(uid: uid, name: name);
}

class _VendorPageState extends State<VendorPage> {

  String uid;
  String name;
  _VendorPageState({this.uid, this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Basic Info").doc(uid).snapshots(),
        builder: (context, snapshot){
          if(snapshot.data == null){
            return Center(child: CircularProgressIndicator());
          }
          return SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(snapshot.data['name']),
                  ElevatedButton(
                    onPressed:(){
                      Navigator.of(context).pop();
                    },
                    child: Text("Back"),
                  ),
                ],
              )
            ),
          );
        }
      ),
    );
  }
}