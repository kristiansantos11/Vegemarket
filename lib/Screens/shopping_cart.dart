import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vegemarket/Model/itemData.dart';
import 'package:vegemarket/Services/database/FetchShoppingCart.dart';
import 'package:provider/provider.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({ Key key }) : super(key: key);

  static const routeName = "/shopping_cart";

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    User user = context.watch<User>();
    if(user==null){
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return StreamBuilder<List<ItemData>>(
      stream: ShoppingCartGetter(user).itemListData,
      builder: (context, snapshot) {
        if((snapshot.data==null)||(snapshot==null)){
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        }
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Shopping Cart",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Proxima Nova"
              ),
            ),
            toolbarHeight: 65,
            backgroundColor: Colors.green,
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.black45,
                            width: 0.5,
                          ),
                        ),
                        child: InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    child: FadeInImage(
                                      placeholder: AssetImage('assets/img/missing_item_icon.jpg'),
                                      image: NetworkImage(snapshot.data[index].itemPictureLink),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0,0,100,0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: snapshot.data[index].itemName,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Proxima Nova',
                                          fontSize: 25,
                                          fontWeight: FontWeight.w700,
                                        ),
                                        children: [
                                          TextSpan(
                                            text: "\n" + snapshot.data[index].username,
                                            style: TextStyle(
                                              color: Colors.black54,
                                              fontFamily: 'Proxima Nova',
                                              fontSize: 17,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(24,0,0,0),
                                child: ElevatedButton(
                                  style: ButtonStyle(
                                    fixedSize: MaterialStateProperty.all(Size(30, 120)),
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(12), bottomRight: Radius.circular(12))),
                                    ),
                                  ),
                                  onPressed: (){},
                                  child: Icon(Icons.delete)
                                ),
                              ),
                              
                            ],
                          ),
                        )
                      ),
                    );
                  },
                )
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(24,0,24,0),
                child: ElevatedButton(
                  onPressed: (){
                    FirebaseFirestore.instance
                                     .collection('Basic Info')
                                     .doc(user.uid)
                                     .collection('cart')
                                     .get()
                                     .then((snapshot) {
                      for (DocumentSnapshot ds in snapshot.docs){
                        ds.reference.delete();
                      }
                    });
                  },
                  style: ButtonStyle(
                    fixedSize: MaterialStateProperty.all(Size(200,50)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))
                      ),
                    ),
                  ),
                  child: Text("Empty Cart")
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}