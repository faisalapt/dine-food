import 'package:dine_food/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              return Text("Loading");
            }
            if (state is CartEmpty) {
              return Text("Cart Empty");
            }
            if (state is CartLoadded) {
              int total = 0;
              state.cart.details!.forEach((v) {
                total += (v.qty! * v.menu!.price!);
              });
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
                                                  horizontal: 10),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 15),
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
                                                  SizedBox(
                                                    width: 10,
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
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text("Total Harga: "),
                              Text(total.toString())
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Center(
                                child: Text("Order"),
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
}
