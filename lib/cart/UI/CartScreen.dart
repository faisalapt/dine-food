import 'package:dine_food/cart/UI/CartWidget.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff99B898),
        elevation: 0,
        title: Text(
          "Cart",
          style: TextStyle(
            fontFamily: "Cocogoose-Regular",
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
      ),
      body: CartWidget(),
    );
  }
}
