import 'package:bloc/bloc.dart';
import 'package:dine_food/home/customer/models/Stores.dart';
import 'package:dine_food/home/customer/services/api.dart';
import 'package:equatable/equatable.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  StoreBloc() : super(StoreInitial()) {
    on<LoadStore>((event, emit) async {
      emit(StoreLoading());
      var response = ApiCustomer().getStore(event.search);

      await response.whenComplete(() async {
        await response.then((value) {
          if (value.responStatus!.code == 200) {
            emit(StoreLoaded(stores: value.data!.stores!));
          } else {
            emit(StoreError());
          }
        });
      });
    });
  }
}
