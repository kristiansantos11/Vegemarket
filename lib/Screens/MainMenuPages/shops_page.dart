import 'package:flutter/material.dart';

class ShopsPage extends StatefulWidget {
  const ShopsPage({ Key? key }) : super(key: key);

  @override
  _ShopsPageState createState() => _ShopsPageState();
}

class _ShopsPageState extends State<ShopsPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.amber[700],
        ),
        child: Center(
          child: Text(
            "Shops Page",
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