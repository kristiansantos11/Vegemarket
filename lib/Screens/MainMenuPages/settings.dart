import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:vegemarket/Services/AuthenticationService.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  const Settings({ Key? key }) : super(key: key);

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
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.0), color: Colors.white),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Settings",
                style: TextStyle(
                  fontFamily: "Nexa",
                  fontWeight: FontWeight.w700,
                  fontSize: 35,
                  color: Colors.black,
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
                      color: Colors.white,
                    ),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple[800]),
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