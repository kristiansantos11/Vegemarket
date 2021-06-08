import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegemarket/Screens/initial_screen.dart';
import 'package:vegemarket/Screens/login.dart';
import 'package:vegemarket/Screens/main_menu.dart';
import 'package:vegemarket/Screens/register.dart';

Route<Null>? getGenerateRoute(RouteSettings settings){
  final arguments = settings.arguments;

  switch(settings.name){

    case InitialScreen.routeName:
      return PageRouteBuilder(
        settings: RouteSettings(name: InitialScreen.routeName),
        pageBuilder: (context, animation, secondaryAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: InitialScreen(),
          );
        }
      );

    case Login.routeName:
      return PageRouteBuilder(
        settings: RouteSettings(name: Login.routeName),
        pageBuilder: (context, animation, secondaryAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: Login(),
          );
        }
      );

    case Register.routeName:
      return PageRouteBuilder(
        settings: RouteSettings(name: Register.routeName),
        pageBuilder: (context, animation, secondaryAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: Register(),
          );
        }
      );

    case MainMenu.routeName:
      return PageRouteBuilder(
        settings: RouteSettings(name: MainMenu.routeName),
        pageBuilder: (context, animation, secondaryAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: MainMenu(),
          );
        }
      );
  }
  return null;
}