import 'package:dine_food/cart/models/response/CartResponse.dart';
import 'package:dine_food/cart/models/response/Record.dart';
import 'package:dine_food/home/store/show/models/StoreResponse.dart';
import 'package:dine_food/utils/ApiUtils.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/response/ResponStatus.dart';
import '../models/response/Data.dart';

class ApiCart extends ApiUtils {
  Future<CartResponse> getCart() async {
    mPreferences = await SharedPreferences.getInstance();
    final String token = mPreferences!.getString("token") ?? '';

    var response = await dio.get('/cart',
        options: Options(headers: {"Authorization": "Bearer " + token}));
    CartResponse cart;
    if (response.statusCode == 200) {
      cart = CartResponse(
          responStatus: ResponStatus.fromJson(response.data['respon_status']),
          data: Data.fromJson(response.data['data']));
    } else {
      cart = CartResponse(
          responStatus: ResponStatus.fromJson(response.data['respon_status']));
    }
    return cart;
  }

  Future<CartResponse> updateCart(Record cart) async {
    mPreferences = await SharedPreferences.getInstance();
    final String token = mPreferences!.getString("token") ?? '';
    var response = await dio.put("/cart/" + cart.id!,
        options: Options(headers: {"Authorization": "Bearer " + token}),
        data: cart.toJson());
    CartResponse res = CartResponse(
        responStatus: ResponStatus.fromJson(response.data['respon_status']));
    return res;
  }

  Future<CartResponse> addCart(Record cart) async {
    mPreferences = await SharedPreferences.getInstance();
    final String token = mPreferences!.getString("token") ?? '';
    var response = await dio.post("/cart",
        options: Options(headers: {"Authorization": "Bearer " + token}),
        data: cart.toJson());
    CartResponse res = CartResponse(
        responStatus: ResponStatus.fromJson(response.data['respon_status']));

    return res;
  }

  Future<CartResponse> orderCart(Record cart) async {
    mPreferences = await SharedPreferences.getInstance();
    final String token = mPreferences!.getString("token") ?? '';
    var response = await dio.post(
      "/order",
      options: Options(
        headers: {
          "Authorization": "Bearer " + token,
        },
      ),
      data: cart.toJson(),
    );
    CartResponse cartResponse;
    if (response.statusCode == 200) {
      var resDelete = await dio.delete(
        "/cart/" + cart.id!,
        options: Options(
          headers: {
            "Authorization": "Bearer " + token,
          },
        ),
      );
      if (resDelete.statusCode == 200) {
        cartResponse = CartResponse(
          responStatus: ResponStatus.fromJson(response.data['respon_status']),
        );
        return cartResponse;
      }
      cartResponse = CartResponse(
        responStatus: ResponStatus.fromJson(resDelete.data['respon_status']),
      );
      return cartResponse;
    }
    cartResponse = CartResponse(
      responStatus: ResponStatus.fromJson(response.data['data']),
    );
    return cartResponse;
  }
}
