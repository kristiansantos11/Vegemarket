import 'package:flutter/material.dart';

class Messaging extends StatefulWidget {
  const Messaging({ Key? key }) : super(key: key);

  @override
  _MessagingState createState() => _MessagingState();
}

class _MessagingState extends State<Messaging> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.green[500],
        ),
        child: Center(
          child: Text(
            "Messaging",
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