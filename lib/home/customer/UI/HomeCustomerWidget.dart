import 'package:dine_food/home/customer/UI/HomeStoreWidget.dart';
import 'package:dine_food/home/customer/UI/SideMenu.dart';
import 'package:dine_food/home/customer/bloc/store_customer_bloc.dart';
import 'package:dine_food/home/customer/models/Customer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';

class HomeCustomer extends StatefulWidget {
  const HomeCustomer({super.key});

  @override
  State<HomeCustomer> createState() => _HomeCustomerState();
}

class _HomeCustomerState extends State<HomeCustomer> {
  StoreCustomerBloc bloc = StoreCustomerBloc();
  @override
  void initState() {
    // TODO: implement initState
    bloc.add(LoadCustomer(customer: Customer()));
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: Column(
        children: [
          BlocListener<StoreCustomerBloc, StoreCustomerState>(
            bloc: bloc,
            listener: (_, StoreCustomerState state) => {},
            child: BlocBuilder<StoreCustomerBloc, StoreCustomerState>(
              builder: (_, StoreCustomerState state) {
                if (state is StoreCustomerLoading) {
                  return Text("Loading");
                }
                if (state is StoreCustomerLoaded) {
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        HomeLoaded(
                          customer: state.customer,
                        ),
                        HomeStoreWidget()
                      ],
                    ),
                  );
                }
                return Center(
                    child: Container(
                  child: Text("Error"),
                ));
              },
            ),
          )
        ],
      ),
    );
  }
}

class HomeLoaded extends StatelessWidget {
  const HomeLoaded({super.key, required this.customer});

  final Customer customer;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hello",
                style: TextStyle(
                  fontFamily: "Cocogoose-Regular",
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Text(
                customer.name ?? "",
                style: TextStyle(
                  fontFamily: "Cocogoose-Regular",
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
