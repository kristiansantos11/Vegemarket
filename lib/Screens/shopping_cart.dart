import 'package:flutter/material.dart';

class ShoppingCartScreen extends StatefulWidget {
  const ShoppingCartScreen({ Key key }) : super(key: key);

  static const routeName = "/shopping_cart";

  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
      stream: null,
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Shopping Cart",
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    
                  ],
                )
              ),
            ],
          ),
        );
      }
    );
  }
}