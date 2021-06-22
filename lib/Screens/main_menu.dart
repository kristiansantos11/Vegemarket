import 'package:flutter/material.dart';
import 'package:vegemarket/Screens/MainMenuPages/messaging.dart';
import 'package:vegemarket/Screens/MainMenuPages/profile.dart';
import 'package:vegemarket/Screens/MainMenuPages/settings.dart';
import 'package:vegemarket/Screens/MainMenuPages/shops_page.dart';
import 'package:vegemarket/Services/AuthenticationService.dart';
import 'package:provider/provider.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_circular_text/circular_text.dart';
import 'package:vegemarket/Services/SizeGetter.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({ Key? key }) : super(key: key);

  static const routeName = '/main_menu';

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int? currentPage;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> pageWidget = [
    MainMenuStart(), 
    // Shops Page
    ShopsPage(),

    // Messaging
    Messaging(),

    // Profile
    Profile(),

    // Settings
    Settings(),
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      currentPage = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 65,
          centerTitle: true,
          shadowColor: Colors.white,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height/15,
                maxWidth: MediaQuery.of(context).size.width/2
              ),
              child: Image.asset("assets/img/vegemarket-text.png",),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 16,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[

                // # Home button
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentPage = 0;
                      });
                    },
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(85, 75)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35),
                            ), 
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            (currentPage == 0) ? Colors.blue[300] : Colors.grey)),
                    child: Icon(Icons.home_filled, color: Colors.white)
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentPage = 1;
                      });
                    },
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(85, 75)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35),
                            ), 
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            (currentPage == 1) ? Colors.amber[700] : Colors.grey)),
                    child: Icon(Icons.shopping_cart, color: Colors.white)
                ),
                // # Calendar button
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentPage = 2;
                      });
                    },
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(85, 75)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35),
                            ), 
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            (currentPage == 2) ? Colors.green[500] : Colors.grey)),
                    child: Icon(Icons.message_outlined, color: Colors.white)),
                // # Freedom Wall Button
                ElevatedButton(
                    onPressed: () {
                      setState(() {
                        currentPage = 3;
                      });
                    },
                    style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(85, 75)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35),
                            ), 
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            (currentPage == 3) ? Color(0xffff8383) : Colors.grey)),
                    child: Icon(Icons.person, color: Colors.white)),
                // # App Settings button
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                        currentPage = 4;
                      });
                  },
                  style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(Size(85, 75)),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35),
                            ), 
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all(
                            (currentPage == 4) ? Colors.purple[700] : Colors.grey)),
                  child: Icon(Icons.settings, color: Colors.white)
                ),
                
              ],
            ),
          ),
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        switchInCurve: Curves.easeInOutQuad,
        switchOutCurve: Curves.easeInOutQuad,
        transitionBuilder: (child, animation){
          Animation<Offset> offsetAnimation = Tween<Offset>(begin: Offset(0,1), end: Offset(0,0)).animate(animation);
          return SlideTransition(
            child: child,
            position: offsetAnimation,
          );
        },
        child: pageWidget[currentPage!],
      ),
      ),
    );
  }
}

class MainMenuStart extends StatefulWidget {
  const MainMenuStart({ Key? key }) : super(key: key);

  @override
  _MainMenuStartState createState() => _MainMenuStartState();
}

class _MainMenuStartState extends State<MainMenuStart> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0), color: Colors.white),
        child: Stack(
                children: <Widget>[

                  // TODO: # Lagay nalang yung path sa loob ng AssetImage widget.
                  // Container(
                  //   decoration: BoxDecoration(image: DecorationImage(
                  //     image: AssetImage('')
                  //   )),
                  // ),

                  OverflowBox(
                    minWidth: 0.0,
                    minHeight: 0.0,
                    maxWidth: double.infinity,
                    maxHeight: double.infinity,
                    child: Container(
                      alignment: Alignment.center,
                      child: CircularText(
                        children: [
                          TextItem(
                            text: Text(
                              "How about ordering some veggies today?".toUpperCase(),
                              style: TextStyle(
                                fontSize: 40,
                                fontFamily: "Creamy Coconut",
                                color: Colors.blue[300],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            space: 2.15,
                            startAngle: -90,
                            startAngleAlignment: StartAngleAlignment.center,
                            direction: CircularTextDirection.clockwise,
                          ),
                        ],
                        radius: 300,
                        position: CircularTextPosition.outside,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class PageViewMainMenu extends StatefulWidget {
  const PageViewMainMenu({ Key? key }) : super(key: key);

  @override
  _PageViewMainMenuState createState() => _PageViewMainMenuState();
}

class _PageViewMainMenuState extends State<PageViewMainMenu> {
  PageController? pageController;
  int? currentPage;

  @override
  Widget build(BuildContext context) {
    return PageView(
          onPageChanged: (page) {
            setState(() {
              currentPage = page;
            });
          },
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Stack(
                    children: <Widget>[

                      // TODO: # Lagay nalang yung path sa loob ng AssetImage widget.
                      // Container(
                      //   decoration: BoxDecoration(image: DecorationImage(
                      //     image: AssetImage('')
                      //   )),
                      // )

                      OverflowBox(
                        minWidth: 0.0,
                        minHeight: 0.0,
                        maxWidth: double.infinity,
                        maxHeight: double.infinity,
                        child: CircularText(
                          children: [
                            TextItem(
                              text: Text(
                                "How about ordering some veggies today?".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 40,
                                  fontFamily: "Creamy Coconut",
                                  color: Colors.blue[300],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              space: 2.15,
                              startAngle: -90,
                              startAngleAlignment: StartAngleAlignment.center,
                              direction: CircularTextDirection.clockwise,
                            ),
                          ],
                          radius: 300,
                          position: CircularTextPosition.outside,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Shops Page
            ShopsPage(),

            // Messaging
            Messaging(),

            // Profile
            Profile(),

            // Settings
            Settings(),
          ],
        );
  }
}