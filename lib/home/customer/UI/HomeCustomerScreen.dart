import 'package:dine_food/home/customer/UI/HomeCustomerWidget.dart';
import 'package:dine_food/home/customer/UI/SideMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeCustomerScreen extends StatelessWidget {
  const HomeCustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff99B898),
      appBar: AppBar(
        backgroundColor: Color(0xff99B898),
        elevation: 0,
      ),
      body: HomeCustomer(),
      drawer: SideMenu(),
    );
  }
}
