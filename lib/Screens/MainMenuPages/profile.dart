import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:vegemarket/Services/AuthenticationService.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({ Key? key }) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.red[300],
        ),
        child: Center(
          child: Text(
            "Profile",
            style: TextStyle(
              fontFamily: "Nexa",
              fontWeight: FontWeight.w700,
              fontSize: 35,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}