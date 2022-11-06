import 'package:dine_food/home/customer/models/StoreResponseModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/CustomerResponse.dart';
import '../models/DataStore.dart';
import '../models/ResponStatus.dart';
import '../models/Data.dart';
import 'package:dine_food/utils/ApiUtils.dart';
import 'package:dio/dio.dart';

class ApiCustomer extends ApiUtils {
  Future<CustomerResponse> getCustomer() async {
    mPreferences = await SharedPreferences.getInstance();
    final String id = mPreferences!.getString('id') ?? '';
    final String token = mPreferences!.getString('token') ?? '';
    var response = await ApiUtils().dio.get('/user/' + id,
        options: Options(headers: {"Authorization": "Bearer " + token}));
    if (response.statusCode == 200) {
      CustomerResponse customer = CustomerResponse(
          responStatus: ResponStatus.fromJson(response.data['respon_status']),
          data: Data.fromJson(response.data['data']));

      return customer;
    }
    CustomerResponse customer = CustomerResponse(
        responStatus: ResponStatus.fromJson(response.data['respon_status']));
    return customer;
  }

  Future<StoreResponseModel> getStore(String? q) async {
    mPreferences = await SharedPreferences.getInstance();
    final String token = mPreferences!.getString("token") ?? '';
    var response = await ApiUtils().dio.get("/store",
        queryParameters: {"q": q != null ? q : null},
        options: Options(headers: {"Authorization": "Bearer " + token}));
    if (response.statusCode == 200) {
      StoreResponseModel model = StoreResponseModel(
          responStatus: ResponStatus.fromJson(response.data['respon_status']),
          data: DataStore.fromJson(response.data['data']));

      return model;
    }

    StoreResponseModel model = StoreResponseModel(
        responStatus: ResponStatus.fromJson(response.data['respon_status']));
    return model;
  }
}
