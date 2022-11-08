import 'package:dine_food/cart/UI/CartScreen.dart';
import 'package:dine_food/cart/bloc/cart_bloc.dart';
import 'package:dine_food/home/HomaPage.dart';
import 'package:dine_food/home/customer/UI/HomeCustomerSCreen.dart';
import 'package:dine_food/home/customer/UI/HomeCustomerWidget.dart';
import 'package:dine_food/home/customer/bloc/store_bloc.dart';
import 'package:dine_food/home/customer/bloc/store_customer_bloc.dart';
import 'package:dine_food/home/partner/UI/HomePartner.dart';
import 'package:dine_food/home/store/show/bloc/show_store_bloc.dart';
import 'package:dine_food/login/UI/login.dart';
import 'package:dine_food/orders/UI/OrderScreen.dart';
import 'package:dine_food/orders/bloc/order_bloc.dart';
import 'package:dine_food/register/customer/UI/register_customer.dart';
import 'package:dine_food/register/partner/UI/register_partner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'utils/Pallete.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ShowStoreBloc()),
        BlocProvider(create: (context) => StoreCustomerBloc()),
        BlocProvider(create: (context) => StoreBloc()),
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider(create: (context) => OrderBloc())
      ],
      child: MaterialApp(
        title: 'Dine Food',
        home: Scaffold(body: HomePage()),
        initialRoute: '/home-page',
        routes: {
          "/home-page": (context) => HomePage(),
          "/login": (context) => LoginScreen(),
          "/register": (context) => RegisterCustomerScreen(),
          "/register-partner": (context) => RegisterPartner(),
          "/home": (context) => HomeCustomerScreen(),
          "/home-partner": (context) => HomePartner(),
          "/cart": (context) => CartScreen(),
          "/order": (context) => OrderScreen()
        },
      ),
    );
  }
}
