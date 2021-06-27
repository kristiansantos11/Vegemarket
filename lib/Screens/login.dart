import 'package:vegemarket/Screens/initial_screen.dart';
import 'package:vegemarket/Services/AuthenticationService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  static const routeName = '/login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  final _emailTextController = TextEditingController();
  final _pwTextController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void backButtonPressed(BuildContext ctx) {
    Navigator.of(ctx).popUntil(ModalRoute.withName(InitialScreen.routeName));
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _pwTextController.dispose();
    _emailTextController.dispose();
    super.dispose();
  }

  void _signInWithEmailAndPassword(ctx) async {
    var _success = true;
    var outMsg;
    if ((_emailTextController.text.isEmpty) ||
        (_pwTextController.text.isEmpty)) {
      outMsg = "Please fill up the necessary fields.";
      return showDialog(
          context: ctx,
          builder: (ctx) {
            return AlertDialog(content: Text(outMsg));
          });
    }

    await context
        .read<AuthenticationService>()
        .signIn(
            email: _emailTextController.text.trim(),
            password: _pwTextController.text.trim())
        .then((_) => {backButtonPressed(context)})
        .catchError((e) => {
              _success = false,
              showDialog(
                  context: ctx,
                  builder: (ctx) {
                    return AlertDialog(content: Text(e.message));
                  })
            });

    if (_success) {
      dynamic scaffold = ScaffoldMessenger.of(ctx);
      await scaffold.showSnackBar(
        SnackBar(
          content: const Text('Logged in'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            
            // Background
            Container(),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                RichText(
                  textAlign: TextAlign.right,
                  text: TextSpan(
                    text: "vegemarket",
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Gilbert Color",
                      fontSize: 75,
                      height: 0.5,
                    ),
                    children: <InlineSpan>[
                      TextSpan(
                        text: "\npowered by JOMAHEK",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Proxima Nova",
                        ),
                      ),
                    ],
                  ), 
                ),

                SizedBox(
                  height: 45,
                ),

                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(50, 20, 50, 0),
                        child: TextFormField(
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter your e-mail';
                            }
                            return null;
                          },
                          controller:
                              _emailTextController,
                          cursorColor: Color(0xfff77272),
                          style: TextStyle(
                              fontFamily: 'Proxima Nova',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white54
                          ),
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(
                                    30, 0, 30, 0),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(
                                Radius.circular(100.0),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            hintStyle: TextStyle(
                                color: Colors.white24),
                            hintText: "Email",
                            fillColor: Colors.grey[600],
                          ),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.fromLTRB(50, 10, 50, 0),
                        child: TextFormField(
                          cursorColor: Color(0xfff77272),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                          controller: _pwTextController,
                          style: TextStyle(
                              fontFamily: 'Proxima Nova',
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white54),
                          obscureText: true,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(30, 0, 30, 0),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(100.0),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            hintStyle: TextStyle(
                                color: Colors.white24),
                            hintText: "Password",
                            fillColor: Colors.grey[600],
                          ),
                        ),
                      ),
                    ]
                  )
                ),

                  SizedBox(
                    height: 15,
                  ),

                ButtonBar(
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () => {
                        // TODO: Add login firebase function here
                        _signInWithEmailAndPassword(context)
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red[300]),
                        fixedSize: MaterialStateProperty.all(Size(100, 35)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)))
                      ),
                      child: Text(
                        "LOGIN",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Proxima Nova',
                          fontWeight: FontWeight.w700
                        ),
                      )
                    ),
                    ElevatedButton(
                      onPressed: () => {
                        // TODO: Add login firebase function here
                        Navigator.of(context).pop()
                      }, 
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red[300]),
                        fixedSize: MaterialStateProperty.all(Size(100, 35)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)))
                      ),
                      child: Text(
                        "BACK",
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'Proxima Nova',
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ),
                  ]
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}