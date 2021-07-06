import 'package:flutter/material.dart';
import 'package:vegemarket/Screens/message_screen.dart';

class Messaging extends StatefulWidget {
  const Messaging({ Key key }) : super(key: key);

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:[
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Messaging",
                  style: TextStyle(
                    fontFamily: "Proxima Nova",
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    fontSize: 30,
                  ),  
                ),
              ),

              InkWell(
                onTap: (){
                  Navigator.of(context).pushNamed(MessageScreen.routeName);
                },
                child: Padding(
                  padding: EdgeInsets.fromLTRB(12,20,12,20),
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          foregroundImage: AssetImage("assets/img/default_profile_picture.jpg"),
                          radius: 35,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(30,0,0,0),
                          child: Text("maverick"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}