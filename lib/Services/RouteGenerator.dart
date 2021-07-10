

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegemarket/Screens/MainMenuPages/profile.dart';
import 'package:vegemarket/Screens/ScreenArguments/ItemPageArguments.dart';
import 'package:vegemarket/Screens/ScreenArguments/ItemScreenArguments.dart';
import 'package:vegemarket/Screens/ScreenArguments/VendorScreenArguments.dart';
import 'package:vegemarket/Screens/ScreenArguments/VendorSearchArguments.dart';
import 'package:vegemarket/Screens/add_item_screen.dart';
import 'package:vegemarket/Screens/askItemPicture.dart';
import 'package:vegemarket/Screens/askProfilePicture.dart';
import 'package:vegemarket/Screens/initial_screen.dart';
import 'package:vegemarket/Screens/items_screen.dart';
import 'package:vegemarket/Screens/login.dart';
import 'package:vegemarket/Screens/main_menu.dart';
import 'package:vegemarket/Screens/message_screen.dart';
import 'package:vegemarket/Screens/register.dart';
import 'package:vegemarket/Screens/vendorSearchResults.dart';
import 'package:vegemarket/Screens/vendor_page/vendorPage.dart';

Route<Null> getGenerateRoute(RouteSettings settings){
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
    
    case AskProfilePicture.routeName:
      return PageRouteBuilder(
        settings: RouteSettings(name: AskProfilePicture.routeName),
        pageBuilder: (context, animation, secondaryAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: AskProfilePicture(),
          );
        }
      );

    case VendorPage.routeName:
      final args = settings.arguments as VendorScreenArguments;
      return PageRouteBuilder(
        settings: RouteSettings(name: VendorPage.routeName),
        pageBuilder:(context, animation, secondaryAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: VendorPage(
              uid: args.uid,
              name: args.name,
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child){
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      );

    case VendorSearchResults.routeName:
      final args = settings.arguments as VendorSearchArguments;
      return PageRouteBuilder(
        settings: RouteSettings(name: VendorSearchResults.routeName),
        pageBuilder: (context, animation, secondaryAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: VendorSearchResults(
              nameSearch: args.name
            ),
          );
        }
      );

     case AddItem.routeName:
      return PageRouteBuilder(
        settings: RouteSettings(name: AddItem.routeName),
        pageBuilder: (context, animation, secondaryAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: AddItem(),
          );
        },
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child){
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      );

    case AskItemPicture.routeName:
      final args = settings.arguments as Map<String,dynamic>;
      return PageRouteBuilder(
        settings: RouteSettings(name: AskItemPicture.routeName),
        pageBuilder: (context, animation, secondaryAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: AskItemPicture(
              itemName: args["itemName"]
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child){
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      );
    
    case MessageScreen.routeName:
      return PageRouteBuilder(
        settings: RouteSettings(name: MessageScreen.routeName),
        pageBuilder: (context, animation, secondaryAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: MessageScreen(),
          );
        }
      );

      case Profile.routeName: //added
      return PageRouteBuilder(
        settings: RouteSettings(name: Profile.routeName),
        pageBuilder: (context, animation, secondaryAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: Profile(),
          );
        }
      );

      case ItemsScreen.routeName:
      final args = settings.arguments as ItemScreenArguments;
      return PageRouteBuilder(
        settings: RouteSettings(name: ItemsScreen.routeName),
        pageBuilder: (context, animation, secondaryAnimation){
          return ListenableProvider(
            create: (context) => animation,
            child: ItemsScreen(
              itemName: args.itemName,
              vendorUID: args.vendorUID,
              username: args.username,
              description: args.description,
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 500),
        transitionsBuilder: (context, animation, secondaryAnimation, child){
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      );

  }
  return null;
}

class ItemsScreenArguments {
}