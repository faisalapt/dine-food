import 'package:dine_food/cart/bloc/cart_bloc.dart';
import 'package:dine_food/cart/models/response/Record.dart';
import 'package:dine_food/home/store/show/UI/StoreScreenWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key, required this.name, required this.id});

  final String name;
  final String id;

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        BlocProvider.of<CartBloc>(context).add(InitialCart(cart: Record()));
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text(
            widget.name,
            style: TextStyle(
              fontFamily: "Cocogoose-Regular",
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          backgroundColor: Color(0xff99B898),
          elevation: 0,
        ),
        backgroundColor: Color(0xff99B898),
        body: SingleChildScrollView(child: StoreScreenWidget(id: widget.id)),
      ),
    );
  }
}
