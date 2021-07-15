import 'package:flutter/material.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({ Key key }) : super(key: key);

  static const routeName = "/messaging_screen";

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {

  TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(225,142,191,71),
        title: Text("maverick"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0,0,30,30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,0,20,0),
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey
                              ),
                              child: Text("available po ba tong gulay na to", style: TextStyle(fontSize: 15)),
                            ),
                          ),
                          CircleAvatar(
                            foregroundImage: AssetImage("assets/img/default_profile_picture.jpg"),
                            radius: 35,
                          ),
                        ],
                      ),
                    ),
                  ),

                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30,0,0,30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [

                          CircleAvatar(
                            foregroundImage: AssetImage("assets/img/default_profile_picture.jpg"),
                            radius: 35,
                          ),
                          
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20,0,0,0),
                            child: Container(
                              padding: EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey
                              ),
                              child: Text("sige", style: TextStyle(fontSize: 15)),
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                    color: Color.fromARGB(225,142,191,71),
                  ),
                  child: Column(
                    children: [
                      TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(
                              Radius.circular(30.0),
                            ),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 20, 20, 0),
                              child: TextButton.icon(
                                onPressed: () {
                                  if (_controller.value.text != "")
                                  {                                    
                                  }
                                },
                                icon: Icon(Icons.send, color: Colors.white),
                                label: Text("Send", style: TextStyle(color: Colors.white, fontFamily: 'Proxima Nova'))
                              )
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                              child: TextButton.icon(
                                onPressed: () {
                                  _controller.clear();
                                },
                                icon: Icon(Icons.clear_rounded, color: Colors.white),
                                label: Text("Clear", style: TextStyle(color: Colors.white, fontFamily: 'Proxima Nova'))
                              )
                            ),
                          ]
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}