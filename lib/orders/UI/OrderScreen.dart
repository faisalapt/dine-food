import 'package:dine_food/orders/UI/OrderWidget.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff99B898),
        elevation: 0,
        title: Text(
          "Orders",
          style: TextStyle(
            fontFamily: "Cocogoose-Regular",
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        centerTitle: false,
      ),
      body: OrderWidget(),
    );
  }
}
