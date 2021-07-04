import 'package:flutter/material.dart';
import 'package:vegemarket/Model/userData.dart';
import 'package:vegemarket/Screens/ScreenArguments/VendorScreenArguments.dart';
import 'package:vegemarket/Screens/vendorSearchResults.dart';
import 'package:vegemarket/Screens/vendor_page/vendorPage.dart';
import 'package:vegemarket/Services/database/FetchShopList.dart';

class ShopsPage extends StatefulWidget {
  const ShopsPage({ Key key }) : super(key: key);

  @override
  _ShopsPageState createState() => _ShopsPageState();
}

class _ShopsPageState extends State<ShopsPage> {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String textMessage;

  @override
  Widget build(BuildContext context) {
    var _controller = TextEditingController();
    return StreamBuilder<List<UserData>>(
      stream: SellerListGetter().sellerListData,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting){
          return CircularProgressIndicator();
        } else {
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.amber[700],
            ),
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.fromLTRB(0,10,0,0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                        ElevatedButton(
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(Size(420,20)),
                            backgroundColor: MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))
                          ),
                          onPressed: (){
                            Navigator.of(context).pushNamed(VendorSearchResults.routeName);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Search vendors here!",
                                style: TextStyle(
                                  color: Colors.amber[700],
                                  fontFamily: "Proxima Nova",
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Icon(Icons.search, color: Colors.amber[700]),
                            ],
                          ),
                        ),

                      ],
                    ),
                ),

                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(12),
                    // Checks if snapshot.data is null,
                    // if yes then set itemCount to 0 
                    // else set itemCount to length
                    itemCount: (snapshot.data == null) ? 0 : snapshot.data.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15.0,
                      mainAxisSpacing: 15.0,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                          Navigator.of(context).pushNamed(
                            VendorPage.routeName, 
                            arguments: VendorScreenArguments(
                              uid: snapshot.data[index].uid,
                              name: snapshot.data[index].name,
                            )
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
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  child: FadeInImage.assetNetwork(
                                    placeholder: 'assets/img/default_profile_picture.jpg',
                                    image: snapshot.data[index].profilePictureLink,
                                  ),
                                ),
                                Text(snapshot.data[index].username),
                              ],
                            ),
                          ),
                        ),
                      );

                    },
                  ),
                ),
              ],
            )
          )
        );
        }
        
      }
    );
  }
}