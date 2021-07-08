import 'package:flutter/material.dart';
import 'package:vegemarket/Screens/login.dart';
import 'package:vegemarket/Screens/register.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({ Key key }) : super(key: key);

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

                    Padding(
                    padding: const EdgeInsets.fromLTRB(0,150,0,0),
                    child: Container(
                      height: 150,
                      width: 150,
                    decoration: BoxDecoration(
                    image: DecorationImage(
                    image: AssetImage("assets/img/design-2.png"),
                    ), 
                    )  
                    ),
                  ),

                   Padding(
                    padding: const EdgeInsets.fromLTRB(300,150,0,0),
                    child: Container(
                      height: 170,
                      width: 170,
                    decoration: BoxDecoration(
                    image: DecorationImage(
                    image: AssetImage("assets/img/design-1.png"),
                    ), 
                    )  
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,700,0,0),
                    child: Container(
                      height: 170,
                      width: 170,
                    decoration: BoxDecoration(
                    image: DecorationImage(
                    image: AssetImage("assets/img/design-4.png"),
                    ), 
                    )  
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(320,600,0,0),
                    child: Container(
                      height: 170,
                      width: 170,
                    decoration: BoxDecoration(
                    image: DecorationImage(
                    image: AssetImage("assets/img/design-3.png"),
                    ), 
                    )  
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(260,800,0,0),
                    child: Container(
                      height: 150,
                      width: 150,
                    decoration: BoxDecoration(
                    image: DecorationImage(
                    image: AssetImage("assets/img/design-2.png"),
                    ), 
                    )  
                    ),
                  ),

                 Padding(
                     padding: const EdgeInsets.fromLTRB(40,150,0,0),
                     child: Container(
                     height: 400,
                     width: 400,
                     decoration: BoxDecoration(
                     image: DecorationImage(
                     image: AssetImage("assets/img/LOGO-trans.png"),
                    ), 
                     )  
                     ),
                   ),
              
            
              Padding(
                padding: const EdgeInsets.fromLTRB(43,290,0,0),
                child: Container(
                height: 400,
                width: 400,
                decoration: BoxDecoration(
                image: DecorationImage(
                image: AssetImage("assets/img/vegemarket-text.png"),
                ), 
                )  
                ),
              ),


          // Background here
          Container(),

          // Main components:
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // RichText(
                //     textAlign: TextAlign.right,
                //     text: TextSpan(
                //       text: "vegemarket",
                //       style: TextStyle(
                //         fontFamily: "Gilbert Color",
                //         color: Colors.black,
                //         fontWeight: FontWeight.w500,
                //         fontSize: 75,
                //         height: 0.7,
                //       ),
                //       children: <InlineSpan>[
                //         TextSpan(
                //           text: "\npowered by JOMAHEK",
                //           style: TextStyle(
                //             fontSize: 20,
                //             fontFamily: "Proxima Nova",
                //             fontWeight: FontWeight.w700,
                //           ),
                //         ),
                //       ],
                //     ), 
                //   ),
                
                SizedBox(
                    height: 145,
                  ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,70,0,0),
                      child: Hero(
                        tag: 'register',
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18.0),
                            ),
                            child: TextButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                    MaterialStateProperty.all<Color>(Color.fromARGB(255,161,213,226)),
                                  overlayColor:
                                    MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState>states) {
                                        if (states.contains(MaterialState.hovered)) return Colors.red[500];
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
                                      MaterialStateProperty.all(Size(220, 50)),
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
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0,25,0,0),
                      child: Hero(
                          tag: 'login',
                        child: Container(
                          child: TextButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(
                                      Color.fromARGB(255,172,222,99)),
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                    (Set<MaterialState>states) {
                                      if (states.contains(MaterialState.hovered)) return Colors.red[500];
                                      if (states.contains(MaterialState.pressed)) return Colors.white;
                                      return Color.fromARGB(255,255,131,131); // Defer to the widget's default.
                                    }
                                  ),
                              minimumSize:
                                  MaterialStateProperty.all(Size(220,50)),
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
                      ),
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