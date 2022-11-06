import 'package:dine_food/utils/ApiUtils.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiCheckToken extends ApiUtils {
  Future<Response> checkToken() async {
    mPreferences = await SharedPreferences.getInstance();
    String? id = mPreferences!.getString("id");
    final String token = mPreferences!.getString("token") ?? '';
    var response = await dio.get("/user/" + id!,
        options: Options(headers: {"Authorization": "Bearer " + token}));
    print(response.statusCode);
    return response;
  }
}
