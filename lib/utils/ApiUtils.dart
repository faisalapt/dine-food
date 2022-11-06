import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiUtils {
  static var uri = "https://dine-food.isoae.id/api/v1";
  static BaseOptions options = BaseOptions(
    baseUrl: uri,
    connectTimeout: 30000,
    receiveTimeout: 30000,
    headers: {"Content-Type": "application/json", "Accept": "application/json"},
    validateStatus: (status) {
      return status! < 500;
    },
  );
  Dio dio = Dio(options);
  SharedPreferences? mPreferences;
}
