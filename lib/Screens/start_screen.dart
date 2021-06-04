import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({ Key? key }) : super(key: key);

  static const routeName = '/start';

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // Background here
          Container(),

          // Main components:
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                    textAlign: TextAlign.right,
                    text: TextSpan(
                      text: "vegemarket",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Nexa",
                        fontWeight: FontWeight.w700,
                        fontSize: 75,
                        height: 0.7,
                      ),
                      children: <InlineSpan>[
                        TextSpan(
                          text: "\npowered by JOMAHEK",
                          style: TextStyle(
                            fontSize: 20,
                            fontFamily: "Proxima Nova",
                          ),
                        ),
                      ],
                    ), 
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}