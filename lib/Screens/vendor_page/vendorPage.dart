import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vegemarket/Model/itemData.dart';
import 'package:vegemarket/Screens/ScreenArguments/ItemScreenArguments.dart';
import 'package:vegemarket/Screens/ScreenArguments/VendorScreenArguments.dart';
import 'package:vegemarket/Screens/items_screen.dart';
import 'package:vegemarket/Services/database/FetchItemList.dart';
import 'package:vegemarket/Services/database/FetchVendorItemList.dart';

class VendorPage extends StatefulWidget {
  static const routeName = '/vendor_page';

  final uid;
  final name;

  const VendorPage({ Key key, this.uid, this.name }) : super(key: key);

  @override
  _VendorPageState createState() => _VendorPageState(uid: uid, name: name);
}

class _VendorPageState extends State<VendorPage> {

  String uid;
  String name;
  _VendorPageState({this.uid, this.name});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Basic Info").doc(uid).snapshots(),
      builder: (context, snapshot) {
        if(snapshot.data == null){
          return Center(child: CircularProgressIndicator());
        }
        return StreamBuilder<List<ItemData>>(
          stream: VendorItemListGetter(uid).itemListData,
          builder: (context, items) {
            if((items==null)||(items.data==null)){
              return Scaffold(body: Center(child: CircularProgressIndicator()));
            }
            if(items.data.isEmpty){
              return Scaffold(
                body: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
                      backgroundColor: Colors.amber[700],
                      floating: true,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.pin,
                        centerTitle: true,
                        background: ClipRRect(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
                          child: Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(snapshot.data["profile_picture"]),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                color: Color.fromARGB(100, 0,0,0)
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        snapshot.data["username"],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Proxima Nova",
                                          fontSize: 40, 
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Located in: " + snapshot.data["barangay"] + ", " + snapshot.data["city"],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "BalsamiqSans",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],  
                          )
                        )
                      ),
                      expandedHeight: 300,
                    ),
                    
                    SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            crossAxisSpacing: 5.0,
                            mainAxisSpacing: 5.0,
                      ),
                      
                      delegate: SliverChildBuilderDelegate(
                        (context, index){
                          return Center(
                            child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.white30,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                child: Container(
                                                  alignment: Alignment.center,
                                                  height: 50,
                                                  width: 300,
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors
                                                            .blueGrey[300],
                                                        spreadRadius: 5,
                                                        blurRadius: 8,
                                                        offset: Offset
                                                            .fromDirection(
                                                                1, 5),
                                                      ),
                                                    ],
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      Radius.circular(40),
                                                    ),
                                                    gradient: LinearGradient(
                                                      colors: [
                                                        Colors.blue[900],
                                                        Colors.blue[700]
                                                      ],
                                                      begin: Alignment.topLeft,
                                                      end:
                                                          Alignment.bottomRight,
                                                    ),
                                                  ),
                                                  child: Text(
                                                    'They haven\'t sold anything yet.',
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Proxima Nova',
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                          );
                        },
                        childCount: 1,
                      ),
                    ),
                  ],
                ),

              );
            }
            return Scaffold(
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
                    backgroundColor: Colors.amber[700],
                    floating: true,
                    flexibleSpace: FlexibleSpaceBar(
                      collapseMode: CollapseMode.pin,
                      centerTitle: true,
                      background: ClipRRect(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(snapshot.data["profile_picture"]),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Container(
                              color: Color.fromARGB(100, 0,0,0)
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      snapshot.data["username"],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Proxima Nova",
                                        fontSize: 40, 
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Located in: " + snapshot.data["barangay"] + ", " + snapshot.data["city"],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "BalsamiqSans",
                                        fontStyle: FontStyle.normal,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],  
                        )
                      )
                    ),
                    expandedHeight: 300,
                  ),
                  
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                    ),
                    
                    delegate: SliverChildBuilderDelegate(
                      (context, index){
                        return InkWell(
                          onTap: (){
                            Navigator.of(context).pushNamed(
                              ItemsScreen.routeName,
                              arguments: ItemScreenArguments(
                                itemName: items.data[index].itemName,
                                description: items.data[index].description,
                                username: items.data[index].username,
                                vendorUID: items.data[index].vendorUID,
                              ),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      child: FadeInImage.assetNetwork(
                                        placeholder: 'assets/img/default_profile_picture.jpg',
                                        image: items.data[index].itemPictureLink,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      RichText(
                                        textAlign: TextAlign.center,
                                        text: TextSpan(
                                          text: items.data[index].itemName,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'Proxima Nova',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          children: [
                                            TextSpan(
                                              text: "\n" + items.data[index].username,
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
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: items.data.length ?? 0,
                    ),
                  ),
                ],
              ),

            );
          }
        );

      }
    );
  }
}

