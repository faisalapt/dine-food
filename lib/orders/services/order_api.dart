import 'package:dine_food/orders/models/OrderResponse.dart';
import 'package:dine_food/utils/ApiUtils.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Data.dart';
import '../models/ResponStatus.dart';

class ApiOrder extends ApiUtils {
  Future<OrderResponse> getOrders() async {
    mPreferences = await SharedPreferences.getInstance();
    final String token = mPreferences!.getString("token") ?? '';
    var response = await dio.get(
      "/order",
      options: Options(
        headers: {"Authorization": "Bearer " + token},
      ),
    );
    OrderResponse orderResponse;
    if (response.statusCode == 200) {
      print(response.data);
      orderResponse = OrderResponse(
        responStatus: ResponStatus.fromJson(response.data['respon_status']),
        data: Data.fromJson(response.data['data']),
      );
    } else {
      orderResponse = OrderResponse(
        responStatus: ResponStatus.fromJson(response.data['respon_status']),
      );
    }
    return orderResponse;
  }

  Future<OrderResponse> updateOrder(String mode, String orderNumber) async {
    mPreferences = await SharedPreferences.getInstance();
    final String token = mPreferences!.getString("token") ?? '';
    OrderResponse orderResponse;
    var response = await dio.post(
      "/order/update-status",
      options: Options(
        headers: {"Authorization": "Bearer " + token},
      ),
      data: {"mode": mode, "order_number": orderNumber},
    );

    if (response.statusCode == 200) {
      var res = await dio.get(
        "/order",
        options: Options(
          headers: {"Authorization": "Bearer " + token},
        ),
      );
      if (res.statusCode == 200) {
        orderResponse = OrderResponse(
          responStatus: ResponStatus.fromJson(res.data['respon_status']),
          data: Data.fromJson(res.data['data']),
        );
      } else {
        orderResponse = OrderResponse(
          responStatus: ResponStatus.fromJson(res.data['respon_status']),
        );
        return orderResponse;
      }
    } else {
      orderResponse = OrderResponse(
        responStatus: ResponStatus.fromJson(response.data['respon_status']),
      );
    }

    return orderResponse;
  }
}
