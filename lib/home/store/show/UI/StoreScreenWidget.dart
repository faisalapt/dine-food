import 'package:dine_food/cart/bloc/cart_bloc.dart';
import 'package:dine_food/cart/models/response/Details.dart';
import 'package:dine_food/cart/models/response/Record.dart';
import 'package:dine_food/home/store/show/bloc/show_store_bloc.dart';
import 'package:dine_food/home/store/show/models/Menu.dart';
import 'package:dine_food/home/store/show/models/Records.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StoreScreenWidget extends StatefulWidget {
  const StoreScreenWidget({super.key, required this.id});

  final String id;

  @override
  State<StoreScreenWidget> createState() => _StoreScreenWidgetState();
}

class _StoreScreenWidgetState extends State<StoreScreenWidget> {
  ShowStoreBloc showStoreBloc = ShowStoreBloc();

  @override
  void initState() {
    // TODO: implement initState
    showStoreBloc.add(LoadStore(id: widget.id));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    showStoreBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => showStoreBloc,
      child: Column(
        children: [
          BlocListener<ShowStoreBloc, ShowStoreState>(
            bloc: showStoreBloc,
            listener: (_, ShowStoreState state) => {},
            child: BlocBuilder<ShowStoreBloc, ShowStoreState>(
              bloc: showStoreBloc,
              builder: (_, ShowStoreState state) {
                if (state is ShowStoreLoading) {
                  return Text("Loading");
                }
                if (state is ShowStoreLoaded) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StoreLoadedWidget(state.store),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Our Menus",
                          style: TextStyle(
                            fontFamily: "Cocogoose-Regular",
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        StoreMenuWidget(state.menus)
                      ],
                    ),
                  );
                }
                return Text("Error");
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget StoreLoadedWidget(Store stores) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.37,
                fit: BoxFit.cover,
                image: NetworkImage(
                  stores.logo!,
                  scale: 0.1,
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Text(
            stores.address! +
                ", " +
                stores.city!.name! +
                ", " +
                stores.postalCode!,
            style: TextStyle(
              fontFamily: "Cocogoose-Thin",
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        )
      ],
    );
  }

  Widget StoreMenuWidget(List<Menu> menus) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 7 / 9,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: menus.length,
      itemBuilder: (BuildContext cxt, index) {
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
              builder: (context) => ShowMenuWidget(menus[index]),
            );
          },
          child: Container(
            decoration: BoxDecoration(
                color: Color(0xffB9D7B8),
                borderRadius: BorderRadius.circular(20)),
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image(
                      width: MediaQuery.of(cxt).size.width * 0.4,
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        menus[index].image!,
                        scale: 0.1,
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: MediaQuery.of(cxt).size.width,
                        child: Text(
                          menus[index].name!,
                          style: TextStyle(
                            fontFamily: "Cocogoose-Regular",
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        width: MediaQuery.of(cxt).size.width,
                        child: Text(
                          "Rp. " + menus[index].price!.toString(),
                          style: TextStyle(
                            fontFamily: "Cocogoose-Thin",
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget ShowMenuWidget(Menu menu) {
    int qty = 1;
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
              Container(
                margin: EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image(
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      menu.image!,
                      scale: 0.1,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      menu.name!,
                      style: TextStyle(
                        fontFamily: "Cocogoose-Regular",
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      "Rp. " + menu.price!.toString(),
                      style: TextStyle(
                        fontFamily: "Cocogoose-Thin",
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                      "Qty",
                      style: TextStyle(
                        fontFamily: "Cocogoose-Regular",
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) =>
                        Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if (qty > 1) {
                                qty--;
                              }
                            });
                          },
                          child: Icon(Icons.remove),
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all<Size>(Size(50, 40)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xff2A363B)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 1,
                        ),
                        Container(
                          height: 40,
                          width: 50,
                          color: Color(0xff2A363B),
                          child: Center(
                              child: Text(
                            "$qty",
                            style: TextStyle(
                              fontFamily: "Cocogoose-Thin",
                              color: Colors.white,
                            ),
                          )),
                        ),
                        SizedBox(
                          width: 1,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              qty++;
                            });
                            print(qty);
                          },
                          child: Icon(Icons.add),
                          style: ButtonStyle(
                            minimumSize:
                                MaterialStateProperty.all<Size>(Size(50, 40)),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff2A363B),
                            ),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                  right: Radius.circular(20),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                  onPressed: () {
                    final bloc = BlocProvider.of<CartBloc>(context);
                    bloc.add(InitialCart(cart: Record()));
                    Details detail = new Details(menuId: menu.id, qty: qty);
                    print(detail.toJson());
                    List<Details> details = [];
                    details.add(detail);
                    Record cart =
                        Record(storeId: menu.storeId, details: details);
                    bloc.add(AddCart(cart: cart));
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Add to cart",
                    style: TextStyle(
                      fontFamily: "Cocogoose-Regular",
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
