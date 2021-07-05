import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vegemarket/Screens/askItemPicture.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key key}) : super(key: key);

  static const routeName = '/add_item';

  @override
  _AddItemState createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[600],
      appBar: AppBar(
        toolbarHeight: 65,
        centerTitle: true,
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height / 15,
              maxWidth: MediaQuery.of(context).size.width / 2,
            ),
            child: Image.asset(
              "assets/img/vegemarket-text.png",
            ),
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SafeArea(
                child: Container(
                  height: 500,
                  width: 500,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.blue[800], Colors.blueGrey[900]]),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(50),
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: 'item name',
                            labelText: 'Item Name',
                          ),
                          //controller: ,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(70),
                            topRight: Radius.circular(70),
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          ),
                          color: Colors.white24,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(50),
                          child: Container(
                            width: 400,
                            height: 200,
                            //color: Colors.transparent,
                            child: TextField(
                              maxLength: 250,
                              maxLines: 5,
                              decoration: InputDecoration(
                                labelText: "Item Description",
                                hintText: "Item Desription",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Back'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blue)),
                  onPressed: () {
                    Navigator.of(context).pushNamed(AskItemPicture.routeName);
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
