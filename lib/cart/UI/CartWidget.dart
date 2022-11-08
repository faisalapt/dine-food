import 'package:dine_food/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../models/response/Details.dart';
import '../models/response/Record.dart';

class CartWidget extends StatefulWidget {
  const CartWidget({super.key});

  @override
  State<CartWidget> createState() => _CartWidgetState();
}

class _CartWidgetState extends State<CartWidget> {
  CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    // TODO: implement initState
    cartBloc.add(InitialCart(cart: Record()));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    cartBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => cartBloc,
      child: BlocListener<CartBloc, CartState>(
        bloc: cartBloc,
        listener: (_, CartState state) => {},
        child: BlocBuilder<CartBloc, CartState>(
          bloc: cartBloc,
          builder: (context, CartState state) {
            if (state is CartLoading) {
              return LoadingCart();
            }
            if (state is CartEmpty) {
              return EmptyCart();
            }
            if (state is CartLoadded) {
              int total = 0;
              state.cart.details!.forEach((v) {
                total += (v.qty! * v.menu!.price!);
              });
              var cur = NumberFormat.currency(
                locale: "id_ID",
                symbol: "Rp. ",
              );
              return WillPopScope(
                onWillPop: () async {
                  context.read<CartBloc>().add(UpdateCartApi(cart: state.cart));
                  Navigator.pop(context);
                  return true;
                },
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: SafeArea(
                          child: Card(
                            child: Container(
                              margin: EdgeInsets.all(20),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Container(
                                      child: Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                state.cart.store!.logo!,
                                                scale: 0.1,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.cart.store!.name!,
                                                style: TextStyle(
                                                  fontFamily:
                                                      "Cocogoose-Regular",
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6,
                                                child: Text(
                                                  state.cart.store!.address! +
                                                      ", " +
                                                      state.cart.store!.city!
                                                          .name! +
                                                      ", " +
                                                      state.cart.store!
                                                          .postalCode!,
                                                  style: TextStyle(
                                                    fontFamily:
                                                        "Cocogoose-Thin",
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                      color: Colors.black,
                                    ),
                                    Container(
                                      child: ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        itemCount: state.cart.details!.length,
                                        itemBuilder: (context, index) {
                                          return Card(
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                horizontal: 5,
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                      vertical: 15,
                                                      horizontal: 5,
                                                    ),
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      child: Image(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.2,
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                          state
                                                              .cart
                                                              .details![index]
                                                              .menu!
                                                              .image!,
                                                          scale: 0.1,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.54,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                state
                                                                    .cart
                                                                    .details![
                                                                        index]
                                                                    .menu!
                                                                    .name!,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Cocogoose-Regular",
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 8,
                                                              ),
                                                              Text(
                                                                "Rp. " +
                                                                    state
                                                                        .cart
                                                                        .details![
                                                                            index]
                                                                        .menu!
                                                                        .price!
                                                                        .toString(),
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Cocogoose-Thin",
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              GestureDetector(
                                                                onTap: () {
                                                                  if (state
                                                                          .cart
                                                                          .details![
                                                                              index]
                                                                          .qty! >
                                                                      1) {
                                                                    state
                                                                        .cart
                                                                        .details![
                                                                            index]
                                                                        .qty = state
                                                                            .cart
                                                                            .details![index]
                                                                            .qty! -
                                                                        1;
                                                                    context
                                                                        .read<
                                                                            CartBloc>()
                                                                        .add(
                                                                          UpdateCart(
                                                                            cart:
                                                                                state.cart,
                                                                            detail:
                                                                                state.cart.details![index],
                                                                          ),
                                                                        );
                                                                  } else {
                                                                    context.read<CartBloc>().add(RemoveDetailCart(
                                                                        cart: state
                                                                            .cart,
                                                                        detail: state
                                                                            .cart
                                                                            .details![index]));
                                                                  }
                                                                },
                                                                child: Icon(Icons
                                                                    .remove),
                                                              ),
                                                              SizedBox(
                                                                width: 1,
                                                              ),
                                                              Container(
                                                                height: 40,
                                                                width: 30,
                                                                child: Center(
                                                                  child: Text(
                                                                    state
                                                                        .cart
                                                                        .details![
                                                                            index]
                                                                        .qty
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          "Cocogoose-Thin",
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 1,
                                                              ),
                                                              GestureDetector(
                                                                onTap: () {
                                                                  state
                                                                      .cart
                                                                      .details![
                                                                          index]
                                                                      .qty = state
                                                                          .cart
                                                                          .details![
                                                                              index]
                                                                          .qty! +
                                                                      1;
                                                                  context
                                                                      .read<
                                                                          CartBloc>()
                                                                      .add(
                                                                        UpdateCart(
                                                                          cart:
                                                                              state.cart,
                                                                          detail: state
                                                                              .cart
                                                                              .details![index],
                                                                        ),
                                                                      );
                                                                },
                                                                child: Icon(
                                                                    Icons.add),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      width: double.maxFinite,
                      child: Column(
                        children: [
                          Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Total Harga: "),
                              Text(cur.format(total)),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xff2A363B),
                              ),
                            ),
                            onPressed: () {
                              context
                                  .read<CartBloc>()
                                  .add(OrderCart(cart: state.cart));
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Center(
                                child: Text(
                                  "Order",
                                  style: TextStyle(
                                    fontFamily: "Cocogoose-Regular",
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
            return Text("Error");
          },
        ),
      ),
    );
  }

  Widget LoadingCart() {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: SafeArea(
              child: Card(
                child: Container(
                  margin: EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.white,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image(
                                    width:
                                        MediaQuery.of(context).size.width * 0.2,
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage("assets/default-user.jpg"),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey,
                                      highlightColor: Colors.white,
                                      child: Text(
                                        "Store Name",
                                        style: TextStyle(
                                          fontFamily: "Cocogoose-Regular",
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey,
                                      highlightColor: Colors.white,
                                      child: Text(
                                        "Store Address",
                                        style: TextStyle(
                                          fontFamily: "Cocogoose-Thin",
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: Colors.black,
                        ),
                        Container(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return Card(
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.symmetric(
                                          vertical: 15,
                                          horizontal: 5,
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: Shimmer.fromColors(
                                            baseColor: Colors.grey,
                                            highlightColor: Colors.white,
                                            child: Image(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "assets/default-user.jpg"),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.54,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Shimmer.fromColors(
                                                    baseColor: Colors.grey,
                                                    highlightColor:
                                                        Colors.white,
                                                    child: Text(
                                                      "Menu Name",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "Cocogoose-Regular",
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Shimmer.fromColors(
                                                    baseColor: Colors.grey,
                                                    highlightColor:
                                                        Colors.white,
                                                    child: Text(
                                                      "Rp. 4000",
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "Cocogoose-Thin",
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(20),
          width: double.maxFinite,
          child: Column(
            children: [
              Divider(
                thickness: 1,
                color: Colors.grey,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.white,
                    child: Text("Total Harga: "),
                  ),
                  Shimmer.fromColors(
                    baseColor: Colors.grey,
                    highlightColor: Colors.white,
                    child: Text("Rp. 1000000"),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget EmptyCart() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Icon(
                Icons.remove_shopping_cart,
                size: 60,
              ),
            ),
            Text(
              "Cart is empty",
              style: TextStyle(fontFamily: "Cocogoose-Regular", fontSize: 28),
            ),
          ],
        ),
      ),
    );
  }
}
