import 'package:flutter/material.dart';
import 'package:vegemarket/Screens/login.dart';
import 'package:vegemarket/Screens/register.dart';

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
                        fontFamily: "Gilbert Color",
                        color: Colors.black,
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
                
                SizedBox(
                    height: 145,
                  ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Hero(
                      tag: 'register',
                      child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          child: TextButton(
                              style: ButtonStyle(
                                backgroundColor:
                                  MaterialStateProperty.all<Color>(Color.fromARGB(255,255,131,131)),
                                overlayColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState>states) {
                                      if (states.contains(MaterialState.hovered)) return Colors.red[500]!;
                                      if (states.contains(MaterialState.pressed)) return Colors.white;
                                      return Color.fromARGB(255,255,131,131); // Defer to the widget's default.
                                    }
                                  ),
                                shape:
                                    MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(
                                          35),
                                )),
                                minimumSize:
                                    MaterialStateProperty.all(Size(150, 45)),
                              ),
                              onPressed: () {
                                Navigator.of(context).pushNamed(Register.routeName);
                              },
                              child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      3, 3, 3, 3),
                                  child: Text("JOIN NOW",
                                      style: TextStyle(
                                        fontFamily:
                                            'Proxima Nova',
                                        fontStyle:
                                            FontStyle.normal,
                                        fontSize:
                                            15,
                                        color: Colors.white,
                                        fontWeight:
                                            FontWeight.bold,
                                        letterSpacing: 1,
                                      ))))),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Hero(
                        tag: 'login',
                      child: Container(
                        child: TextButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(
                                    Color.fromARGB(255,255,131,131)),
                            overlayColor:
                                MaterialStateProperty.resolveWith<Color>(
                                  (Set<MaterialState>states) {
                                    if (states.contains(MaterialState.hovered)) return Colors.red[500]!;
                                    if (states.contains(MaterialState.pressed)) return Colors.white;
                                    return Color.fromARGB(255,255,131,131); // Defer to the widget's default.
                                  }
                                ),
                            minimumSize:
                                MaterialStateProperty.all(Size(150,45)),
                            shape:
                                MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(25),
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, Login.routeName);
                          },
                          child: Padding(
                            padding: EdgeInsets.fromLTRB(
                                3, 3, 3, 0),
                            child: Text("LOGIN",
                              style: TextStyle(
                                fontFamily:
                                    'Proxima Nova',
                                fontStyle:
                                    FontStyle.normal,
                                fontSize:
                                    15,
                                color: Colors.white,
                                fontWeight:
                                    FontWeight.bold,
                                letterSpacing: 1,
                              )
                            )
                          )
                        ),
                      )
                    )

                  ]
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}