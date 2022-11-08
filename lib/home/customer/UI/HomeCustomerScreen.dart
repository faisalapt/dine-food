import 'package:dine_food/cart/UI/CartScreen.dart';
import 'package:dine_food/cart/bloc/cart_bloc.dart';
import 'package:dine_food/home/customer/UI/HomeCustomerWidget.dart';
import 'package:dine_food/home/customer/UI/SideMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cart/models/response/Record.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeCustomerScreen extends StatefulWidget {
  const HomeCustomerScreen({super.key});

  @override
  State<HomeCustomerScreen> createState() => _HomeCustomerScreenState();
}

class _HomeCustomerScreenState extends State<HomeCustomerScreen> {
  CartBloc cartBloc = CartBloc();
  var cart;
  @override
  void initState() {
    // TODO: implement initState
    cartBloc.add(InitialCart(cart: Record()));
    cart = BlocProvider.of<CartBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    cartBloc.close();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    cartBloc.add(InitialCart(cart: Record()));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => cartBloc,
      child: BlocListener<CartBloc, CartState>(
        bloc: cartBloc,
        listener: (_, CartState state) => {},
        child: BlocBuilder<CartBloc, CartState>(
          bloc: cartBloc,
          builder: (_, CartState state) {
            if (state is CartLoadded) {
              return Scaffold(
                backgroundColor: Color(0xff99B898),
                appBar: AppBar(
                  backgroundColor: Color(0xff99B898),
                  actions: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(state.cart.user!.avatar!),
                    ),
                  ],
                  elevation: 0,
                ),
                body: RefreshIndicator(
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(
                        parent: BouncingScrollPhysics()),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height,
                      ),
                      child: HomeCustomer(),
                    ),
                  ),
                  onRefresh: () async {
                    cartBloc.add(InitialCart(cart: Record()));
                  },
                ),
                drawer: SideMenu(),
                bottomNavigationBar: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  padding: EdgeInsets.only(bottom: 30),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color(0xff2A363B))),
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(pageBuilder:
                            (context, animation, secondaryAnimation) {
                          return CartScreen();
                        }, transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          final tween =
                              Tween(begin: Offset(0, .5), end: Offset.zero);
                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        }),
                      );
                    },
                    child: Text(
                      state.cart.details!.length.toString() +
                          " item(s) on cart",
                    ),
                  ),
                ),
              );
            }
            return Scaffold(
              backgroundColor: Color(0xff99B898),
              appBar: AppBar(
                backgroundColor: Color(0xff99B898),
                elevation: 0,
              ),
              body: RefreshIndicator(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height,
                    ),
                    child: HomeCustomer(),
                  ),
                ),
                onRefresh: () async {
                  cartBloc.add(InitialCart(cart: Record()));
                },
              ),
              drawer: SideMenu(),
            );
          },
        ),
      ),
    );
  }
}
