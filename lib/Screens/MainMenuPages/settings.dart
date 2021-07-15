import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:vegemarket/Services/AuthenticationService.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({ Key key }) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  void _signOut(BuildContext context) async {
    await context
        .read<AuthenticationService>()
        .signOut()
        .then((String successMsg) {
      print(successMsg);
      Phoenix.rebirth(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0), color: Color.fromARGB(225,60,123,200)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Powered by\n",
                  style: TextStyle(
                    fontFamily: "Proxima Nova",
                    fontSize: 24,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(
                      text: "JOMAHEK\n\n",
                      style: TextStyle(
                        fontFamily: "Nexa",
                        fontSize: 75,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: "Baguio, Mark Godwin\nDataro, Hershey Anne\nSantos, Kristian\nVeneracion, John Elbert",
                      style: TextStyle(
                        fontFamily: "Proxima Nova",
                        fontSize: 24,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ]
                ),
              ),

              ElevatedButton(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "LOGOUT",
                    style: TextStyle(
                      fontFamily: "Nexa",
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                      color: Color.fromARGB(225,60,123,200),
                    ),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25))),
                ),
                onPressed: () => {_signOut(context)},
              ),

            ],
          ),
        ),
      ),
    );
  }
}