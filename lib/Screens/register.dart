// EV_SignUp

/* TODO: Update UI. @bart
 * -> At the top: Add "Register"
 * -> Make the entire screen Scrollable.
 * -> The background Container is temporary.
 * -> The emotion is optional, because I will add a button in the chooseEmotionScreen to skip
*/

import 'dart:io';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:vegemarket/Model/userData.dart';
import 'package:vegemarket/Screens/askProfilePicture.dart';
import 'package:vegemarket/Screens/initial_screen.dart';
import 'package:vegemarket/Services/SizeGetter.dart';
import 'package:vegemarket/Services/database/RegisterAccount.dart';

//debug dont remove this:
// import '../services/database/FetchUserData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  static const routeName = '/signup';

  const Register({Key key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final formKey = GlobalKey<FormState>();
  
  bool toggle1 = true;
  bool toggle2 = true;
  String email;
  String password;
  String username;
  String name;
  DateTime birthday;
  String contactnum;
  String gender;
  String uid;
  dynamic response;
  String error = "";

  void backButtonPressed(BuildContext ctx){
    Navigator.of(ctx).popUntil(ModalRoute.withName(InitialScreen.routeName));
  }

  Future register({@required BuildContext context}) async
  {
    if(formKey.currentState.validate() && birthday != null)
    {
      print("Validated successfully."); //debug
      print("Current Data: $email,$password,$username,$name,$birthday,$contactnum,$gender"); //debug
      print("Attempting to register email & password data to firebase..."); //debug

      UserData _user = UserData(
        email: email,
        password: password,
        username: username,
        name: name,
        birthdate: birthday,
        contactNumber: contactnum,
        profilePicture: File('assets/img/default_profile_picture.jpg'),
        isSeller: 0,
      );

      response = await Database().register(_user);

      print("$response"); //debug - *must be null to be a success
      if(response==null)
      {
        //Navigator.of(context).popUntil(ModalRoute.withName(EVInitialScreen.routeName));
        Navigator.of(context).pushNamed(AskProfilePicture.routeName);

      }
      else
      {
        setState(() {
          error = response;
        });
        showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
              content: Text(
                error
              ),
            );
          }
        );
      }
    }
    else
    {
      print("Not Validated"); //debug

    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
        children: <Widget>[

          // Container(
          //   decoration: BoxDecoration(
          //   image: DecorationImage(
          //   image: AssetImage("assets/img/red-bg.png"),
          //   fit: BoxFit.cover
          //   )
          //   )
          // ),

          // Container(
          //   decoration: BoxDecoration(
          //   image: DecorationImage(
          //   image: AssetImage("assets/img/ss-deco.png"),
          //   ), 
          //   )  
          // ),
                    
          // Opacity(
          //   opacity: 0.5,
          //     child: Container(
          //     decoration: BoxDecoration(
          //     image: DecorationImage(
          //     image: AssetImage("assets/img/ss-deco2.png"),
          //     ), 
          //     )  
          //     ),
          // ),

          
          SafeArea(
            child: Form(
              key: formKey,
                child: ListView(
                  children: [
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.fromLTRB(28, 0, 0, 0),
                      height: getHeight(context) * 0.15,
                      width: getWidth(context),
                      child: Text(
                        "Register now:",
                        style: TextStyle(
                          letterSpacing: -1,
                          height: 0.75,
                          fontFamily: 'Proxima Nova',
                          fontWeight: FontWeight.w800,
                          fontSize: 35,
                          color: Color.fromARGB(225,56,70,127)
                        ),
                      ),
                    ),

                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.fromLTRB(28, 0, 0, 0),
                      child: Text(
                        "Tell us who you are",
                        style: TextStyle(
                          letterSpacing: -1,
                          height: 1,
                          fontFamily: 'Proxima Nova',
                          fontWeight: FontWeight.w700,
                          fontSize: 25,
                          color: Colors.black
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              validator: (val) {
                                if(val=="")
                                {
                                  return "Empty Email";
                                }
                                else
                                {
                                  email = val;
                                  return null;
                                }
                              },
                              cursorColor: Color(0xfff77272),
                                style: TextStyle(
                                    fontFamily: 'Proxima Nova',
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                ),
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(
                                        20, 10, 20, 10),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(
                                    Radius.circular(100.0),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                hintStyle: TextStyle(
                                    color: Colors.grey[400]),
                                hintText: "Email",
                                fillColor: Colors.grey[600],
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row( children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                  validator: (val) {
                                    if(val=="")
                                    {
                                      return "Empty Password";
                                    }
                                    else
                                    {
                                      password = val;
                                      return null;
                                    }
                                  },
                                  obscureText: toggle1,
                                  cursorColor: Color(0xfff77272),
                                  style: TextStyle(
                                      fontFamily: 'Proxima Nova',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(
                                            20, 10, 20, 10),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(
                                        Radius.circular(100.0),
                                      ),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    hintStyle: TextStyle(
                                        color: Colors.grey[400]),
                                    hintText: "Password",
                                    fillColor: Colors.grey[600],
                                  ),
                                ),
                              ),
                              IconButton(
                              onPressed: () {
                                if(toggle1==true)
                                {
                                  toggle1=false;
                                }
                                else{
                                  toggle1=true;
                                }
                                setState(() {});
                              },
                              icon: Icon(Icons.remove_red_eye),
                              color: Colors.black,
                            )
                            ],),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row( children: <Widget>[
                              Expanded(
                                child: TextFormField(
                                validator: (val) {
                                  if(val=="")
                                  {
                                    return "Empty Password";
                                  }
                                  if(val!=password)
                                  {
                                    return "Password do not match";
                                  }
                                  else
                                  {
                                    return null;
                                  }
                                },
                                obscureText: toggle2,
                                cursorColor: Color(0xfff77272),
                                  style: TextStyle(
                                      fontFamily: 'Proxima Nova',
                                      fontStyle: FontStyle.normal,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding:
                                        EdgeInsets.fromLTRB(
                                            20, 10, 20, 10),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(
                                        Radius.circular(100.0),
                                      ),
                                      borderSide: BorderSide.none,
                                    ),
                                    filled: true,
                                    hintStyle: TextStyle(
                                        color: Colors.grey[400]),
                                    hintText: "Confirm Password",
                                    fillColor: Colors.grey[600],
                                  ),
                                ),
                              ),
                            ],),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              validator: (val) {
                                if(val=="")
                                {
                                  return "Empty Username";
                                }
                                else
                                {
                                  username = val;
                                  return null;
                                }
                              },
                              cursorColor: Color(0xfff77272),
                                    style: TextStyle(
                                        fontFamily: 'Proxima Nova',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(
                                          Radius.circular(100.0),
                                        ),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      hintStyle: TextStyle(
                                          color: Colors.grey[400]),
                                      hintText: "Username",
                                      fillColor: Colors.grey[600],
                                    ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              validator: (val) {
                                if(val=="")
                                {
                                  return "Empty Name";
                                }
                                else
                                {
                                  name = val;
                                  return null;
                                }
                              },
                              cursorColor: Color(0xfff77272),
                                    style: TextStyle(
                                        fontFamily: 'Proxima Nova',
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: Colors.white
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding:
                                          EdgeInsets.fromLTRB(
                                              20, 10, 20, 10),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.all(
                                          Radius.circular(100.0),
                                        ),
                                        borderSide: BorderSide.none,
                                      ),
                                      filled: true,
                                      hintStyle: TextStyle(
                                          color: Colors.grey[400]),
                                      hintText: "Name",
                                      fillColor: Colors.grey[600],
                                    ),
                            ),
                          ),

                          SizedBox(height: 20),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Birthday",
                            style: TextStyle(
                                fontFamily: 'Proxima Nova',
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 0.5,
                                color: Colors.black
                            ),),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: DateTimeField(
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Proxima Nova",
                                fontWeight: FontWeight.w700,
                              ),
                              format: DateFormat("yyyy-MM-dd"),
                              onShowPicker: (context, currentValue) {
                                return showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1900),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100)
                                );
                              },
                              onChanged: (DateTime value){
                                setState(() => {birthday = value});
                              },
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.fromLTRB(
                                        20, 10, 20, 10),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(
                                    Radius.circular(100.0),
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                hintText: "Birthday",
                                hintStyle: TextStyle(
                                  color: Colors.grey[400],
                                  fontFamily: 'Proxima Nova',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                ),
                                fillColor: Colors.grey[600],
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              validator: (val) {
                                if(val == "")
                                {
                                  return "Empty number!";
                                }
                                if(RegExp(r'^[0-9]*$').hasMatch(val)&&RegExp(r'$[0-9]\d{10}$|^[0-9]\d{10}$').hasMatch(val))
                                {
                                  contactnum = val;
                                  return null;
                                }
                                else{
                                  return "Input a valid number!";
                                }
                              },
                              cursorColor: Color(0xfff77272),
                                      style: TextStyle(
                                          fontFamily: 'Proxima Nova',
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.white
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding:
                                            EdgeInsets.fromLTRB(
                                                20, 10, 20, 10),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.all(
                                            Radius.circular(100.0),
                                          ),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        hintStyle: TextStyle(
                                            color: Colors.grey[400]),
                                        hintText: "Contact Number",
                                        fillColor: Colors.grey[600],
                                      ),
                            ),
                          ),

                          // Note: Just to add a little distance between Register button and TextFormField
                          // You can remove this SizedBox if you want.
                          SizedBox(
                            height: getHeight(context) / 50,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              
                              Container(
                                child: TextButton(
                                  style: ButtonStyle(
                                    
                                    minimumSize: MaterialStateProperty.all(Size(90, 0)),
                                    padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20.0)
                                      ),
                                    ),

                                    backgroundColor: MaterialStateProperty.all(Color.fromARGB(255,154,162,255)),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).popUntil(ModalRoute.withName(InitialScreen.routeName));
                                  },
                                  child: Text(
                                    "Back",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontFamily: 'Proxima Nova',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              ),

                              TextButton(
                                style: ButtonStyle(
                                  minimumSize: MaterialStateProperty.all(Size(90, 0)),
                                  padding: MaterialStateProperty.all(EdgeInsets.all(15.0)),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20.0)
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(Color(0xffe3b0f7)),
                                ),
                                onPressed: () {register(context: context);},
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontFamily: 'Proxima Nova',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              
                            ],
                          ),

                          // #debug purposes dont remove pls
                          // Center(
                          //   child: TextButton(
                          //     style: ButtonStyle(
                          //       padding: MaterialStateProperty.all(EdgeInsets.all(10.0)),
                          //       backgroundColor: MaterialStateProperty.all(Colors.purple),
                          //     ),
                          //     onPressed: () {
                          //       print("test 123");
                          //     },
                          //     child: Text(
                          //       "DEBUG",
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //       ),
                          //     ),
                          //   ),
                          // ),

                        ],
                      ),
                    )
                  ],
                ),

            ),
          ),
        ]
        )
      );
  }
}