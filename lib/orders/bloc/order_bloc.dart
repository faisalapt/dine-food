import 'package:bloc/bloc.dart';
import 'package:dine_food/orders/services/order_api.dart';
import 'package:equatable/equatable.dart';

import '../models/Records.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<InitialOrder>((event, emit) async {
      emit(OrderLoading());
      try {
        var response = ApiOrder().getOrders();
        await response.whenComplete(() async {
          await response.then((value) {
            if (value.responStatus!.code == 200) {
              if (value.data!.records!.length > 0) {
                emit(OrderLoadded(records: value.data!.records!));
              } else {
                emit(OrderEmpty());
              }
            } else {
              emit(OrderError());
            }
          });
        });
      } catch (e) {
        emit(OrderError());
      }
    });
    on<OrderUpdateStatus>((event, emit) async {
      try {
        var response =
            ApiOrder().updateOrder(event.mode, event.records.orderNumber!);
        await response.whenComplete(() async {
          await response.then((value) {
            if (value.responStatus!.code == 200) {
              emit(OrderLoadded(records: value.data!.records!));
            } else {
              emit(OrderError());
            }
          });
        });
      } catch (e) {
        emit(OrderError());
      }
    });
  }
}
