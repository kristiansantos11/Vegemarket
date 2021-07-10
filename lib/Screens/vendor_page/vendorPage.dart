import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
              StreamBuilder(
                stream: null,
                builder: (context, snapshot) {
                  return SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 15.0,
                          mainAxisSpacing: 15.0,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (content, index){
                        return InkWell(
                          onTap: (){
                            Navigator.of(context).pushNamed(
                              VendorPage.routeName,
                            );
                          },
                          child: Center(
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
                                        image: snapshot.data[index].profilePictureLink,
                                      ),
                                    ),
                                  ),
                                  Text(snapshot.data[index].username),
                                ],
                              ),
                            ),
                          ),
                        );
                      }
                    ),
                  );
                }
              ),
            ],
          ),

        );

      }
    );
  }
}