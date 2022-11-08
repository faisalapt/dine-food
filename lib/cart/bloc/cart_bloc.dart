import 'package:bloc/bloc.dart';
import 'package:dine_food/cart/models/response/CartResponse.dart';
import 'package:dine_food/cart/service/cart_api.dart';
import 'package:equatable/equatable.dart';
import '../models/response/Record.dart';
import '../models/response/Details.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<InitialCart>((event, emit) async {
      emit(CartLoading());
      var response = ApiCart().getCart();
      await response.whenComplete(() async {
        await response.then((value) {
          print(value.data);
          if (value.responStatus!.code == 200) {
            if (value.data!.record != null) {
              emit(CartLoadded(cart: value.data!.record!));
            } else {
              emit(CartEmpty());
            }
          } else {
            emit(CartError());
          }
        });
      });
    });
    on<UpdateCart>((event, emit) async {
      emit(CartLoading());
      final cart = event.cart;
      final update = cart.details!
          .firstWhere((element) => element.menuId == event.detail.menuId);
      update.flag = 1;
      update.qty = event.detail.qty;
      emit(CartLoadded(cart: cart));
    });
    on<RemoveDetailCart>((event, emit) {
      emit(CartLoading());
      final cart = event.cart;
      final detail = event.detail;
      cart.details!.removeWhere((element) => element.menuId == detail.menuId);
      emit(CartLoadded(cart: cart));
    });
    on<UpdateCartApi>((event, emit) async {
      emit(CartLoading());
      try {
        var response = ApiCart().updateCart(event.cart);
        await response.whenComplete(() async {
          await response.then((value) {
            if (value.responStatus!.code == 200) {
              emit(CartLoadded(cart: event.cart));
            } else {
              emit(CartError());
            }
          });
        });
      } catch (e) {
        emit(CartError());
      }
    });
    on<AddCart>((event, emit) async {
      emit(CartLoading());
      try {
        var response = ApiCart().addCart(event.cart);
        await response.whenComplete(() async {
          await response.then((value) {
            if (value.responStatus!.code == 200) {
              emit(CartLoadded(cart: Record()));
            }
            emit(CartError());
          });
        });
      } catch (e) {
        emit(CartError());
      }
    });
    on<OrderCart>((event, emit) async {
      emit(CartLoading());
      try {
        var response = ApiCart().orderCart(event.cart);
        await response.whenComplete(() async {
          await response.then((value) {
            print(event.cart.toJson());
            if (value.responStatus!.code == 200) {
              emit(CartEmpty());
            } else {
              print(value.responStatus!.message);
              emit(CartError());
            }
          });
        });
      } catch (e) {
        print(e);
        emit(CartError());
      }
    });
  }
}
