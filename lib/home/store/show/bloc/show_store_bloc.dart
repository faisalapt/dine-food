import 'package:bloc/bloc.dart';
import 'package:dine_food/home/customer/bloc/store_bloc.dart';
import 'package:dine_food/home/store/show/service/api.dart';
import 'package:equatable/equatable.dart';
import '../models/Records.dart';
import '../models/Menu.dart';

part 'show_store_event.dart';
part 'show_store_state.dart';

class ShowStoreBloc extends Bloc<ShowStoreEvent, ShowStoreState> {
  ShowStoreBloc() : super(ShowStoreInitial()) {
    on<LoadStore>((event, emit) async {
      emit(ShowStoreLoading());

      final response = ApiStoreCustomer().getStore(event.id);
      await response.whenComplete(() async {
        await response.then((value) {
          if (value.responStatus!.code == 200) {
            emit(ShowStoreLoaded(
                store: value.data!.records!,
                menus: value.data!.records!.menu!));
          } else {
            emit(ShowStoreError());
          }
        });
      });
    });
  }
}
