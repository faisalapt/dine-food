import 'package:dine_food/home/store/show/models/StoreResponse.dart';
import 'package:dine_food/utils/ApiUtils.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/ResponStatus.dart';
import '../models/Data.dart';

class ApiStoreCustomer extends ApiUtils {
  Future<StoreResponse> getStore(String id) async {
    mPreferences = await SharedPreferences.getInstance();
    var token = mPreferences!.getString("token");
    var response = await dio.get('/store/' + id,
        options: Options(headers: {"Authorization": "Bearer " + token!}));
    if (response.statusCode == 200) {
      StoreResponse store = StoreResponse(
          responStatus: ResponStatus.fromJson(response.data['respon_status']),
          data: Data.fromJson(response.data['data']));
      return store;
    }

    StoreResponse store = StoreResponse(
        responStatus: ResponStatus.fromJson(response.data['respon_status']));
    return store;
  }
}
