import 'package:bloc/bloc.dart';
import 'package:dine_food/home/customer/models/Customer.dart';
import 'package:dine_food/home/customer/services/api.dart';
import 'package:equatable/equatable.dart';

import '../models/Stores.dart';

part 'store_customer_event.dart';
part 'store_customer_state.dart';

class StoreCustomerBloc extends Bloc<StoreCustomerEvent, StoreCustomerState> {
  StoreCustomerBloc() : super(StoreCustomerInitial()) {
    on<LoadCustomer>((event, emit) async {
      emit(StoreCustomerLoading());
      var response = ApiCustomer().getCustomer();
      Customer cust;
      await response.whenComplete(() async {
        await response.then((value) {
          if (value.responStatus!.code == 200) {
            try {
              cust = value.data!.customer!;
              emit(StoreCustomerLoaded(customer: cust));
            } catch (e) {
              emit(StoreCustomerError());
            }
          }
        });
      });
    });
  }
}
