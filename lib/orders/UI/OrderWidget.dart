import 'package:barcode_widget/barcode_widget.dart';
import 'package:dine_food/orders/bloc/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../models/Records.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  OrderBloc orderBloc = OrderBloc();

  @override
  void initState() {
    // TODO: implement initState
    orderBloc.add(InitialOrder(records: []));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    orderBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => orderBloc,
      child: BlocListener<OrderBloc, OrderState>(
        listener: (_, OrderState state) => {},
        bloc: orderBloc,
        child: BlocBuilder<OrderBloc, OrderState>(
          bloc: orderBloc,
          builder: (_, OrderState state) {
            if (state is OrderLoading) {
              return LoadingOrder();
            }
            if (state is OrderEmpty) {
              return Text("Order Empty");
            }
            if (state is OrderLoadded) {
              return SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: OrderList(state.records),
                  ),
                ),
              );
            }
            return Text("Error");
          },
        ),
      ),
    );
  }

  Widget OrderList(List<Records> orders) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        Color colorsBack = Colors.black;
        Color colorsText = Colors.black;
        String status = orders[index].status ?? '';
        switch (status) {
          case "ORDER":
            colorsBack = Colors.blue[100]!;
            colorsText = Colors.blue;
            break;
          case "CONFIRM":
            colorsBack = Colors.green[100]!;
            colorsText = Colors.green;
            break;
          case "CANCEL":
            colorsBack = Colors.red[100]!;
            colorsText = Colors.red;
            break;
          case "CLOSED":
            colorsBack = Colors.grey[100]!;
            colorsText = Colors.grey;
            break;
        }
        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              builder: (context) => DetailOrder(orders[index]),
            );
          },
          child: Card(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    orders[index].date!,
                    style: TextStyle(fontFamily: "Cocogoose-Thin"),
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image(
                          width: MediaQuery.of(context).size.width * 0.2,
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            orders[index].store!.logo!,
                            scale: 0.1,
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
                            width: MediaQuery.of(context).size.width * 0.7,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  orders[index].store!.name!,
                                  style: TextStyle(
                                    fontFamily: "Cocogoose-Regular",
                                    fontSize: 16,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: colorsBack,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: Text(
                                    orders[index].status!,
                                    style: TextStyle(
                                      fontFamily: "Cocogoose-Regular",
                                      fontSize: 14,
                                      color: colorsText,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              orders[index].store!.address! +
                                  ", " +
                                  orders[index].store!.city!.name! +
                                  ", " +
                                  orders[index].store!.postalCode!,
                              style: TextStyle(
                                fontFamily: "Cocogoose-Thin",
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                if (orders[index].status == "ORDER")
                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.horizontal(
                              right: Radius.circular(20),
                              left: Radius.circular(20),
                            ),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red[200]!),
                      ),
                      onPressed: () {
                        orderBloc.add(OrderUpdateStatus(
                            records: orders[index], mode: "CANCEL"));
                      },
                      child: Text(
                        "Cancel Order",
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
      itemCount: orders.length,
    );
  }

  Widget LoadingOrder() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Card(
          child: Column(
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.white,
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "YYYY-MM-DD HH-II",
                    style: TextStyle(fontFamily: "Cocogoose-Thin"),
                  ),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey,
                        highlightColor: Colors.white,
                        child: Image(
                          width: MediaQuery.of(context).size.width * 0.2,
                          fit: BoxFit.cover,
                          image: AssetImage("assets/default-user.jpg"),
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
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.white,
                                child: Container(
                                  child: Text(
                                    "Menu Name",
                                    style: TextStyle(
                                      fontFamily: "Cocogoose-Regular",
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                              Shimmer.fromColors(
                                baseColor: Colors.grey,
                                highlightColor: Colors.white,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                  ),
                                  child: Text(
                                    "Status",
                                    style: TextStyle(
                                      fontFamily: "Cocogoose-Regular",
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.white,
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.6,
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
            ],
          ),
        );
      },
      itemCount: 3,
    );
  }

  Widget DetailOrder(Records order) {
    return DraggableScrollableSheet(
      snap: true,
      initialChildSize: 0.4,
      maxChildSize: 0.9,
      minChildSize: 0.4,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(15),
            ),
          ),
          child: ListView(
            controller: controller,
            children: [
              Card(
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
                                borderRadius: BorderRadius.circular(15),
                                child: Image(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    order.store!.logo!,
                                    scale: 0.1,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order.store!.name!,
                                    style: TextStyle(
                                      fontFamily: "Cocogoose-Regular",
                                      fontSize: 16,
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.6,
                                    child: Text(
                                      order.store!.address! +
                                          ", " +
                                          order.store!.city!.name! +
                                          ", " +
                                          order.store!.postalCode!,
                                      style: TextStyle(
                                        fontFamily: "Cocogoose-Thin",
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
                        SingleChildScrollView(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(maxHeight: 400),
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: order.details!.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 10),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 15,
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: Image(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                order.details![index].menu!
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.54,
                                          child: Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      order.details![index]
                                                          .menu!.name!,
                                                      style: TextStyle(
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
                                                          order.details![index]
                                                              .menu!.price!
                                                              .toString(),
                                                      style: TextStyle(
                                                        fontFamily:
                                                            "Cocogoose-Thin",
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  "Qty: " +
                                                      order.details![index].qty
                                                          .toString(),
                                                  style: TextStyle(
                                                    fontFamily:
                                                        "Cocogoose-Thin",
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              if (order.status == "ORDER")
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    children: [
                      Text(
                        "Scan this barcode on cashier to confirm your order",
                        style: TextStyle(
                          fontFamily: "Cocogoose-Regular",
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        height: 100,
                        child: BarcodeWidget(
                          data: order.orderNumber!,
                          barcode: Barcode.code128(),
                        ),
                      )
                    ],
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
