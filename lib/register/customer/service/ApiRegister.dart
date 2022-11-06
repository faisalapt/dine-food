import 'dart:io';

import 'package:dine_food/register/customer/models/CustomerResponse.dart';
import 'package:dine_food/register/customer/models/Data.dart';
import 'package:dine_food/register/customer/models/Errors.dart';
import 'package:dine_food/register/customer/models/ResponStatus.dart';
import 'package:dine_food/utils/ApiUtils.dart';
import 'package:dio/dio.dart';

class ApiRegister extends ApiUtils {
  Future<CustomerResponse> register(String name, String email, String username,
      String password, String? avatar) async {
    FormData formData = FormData.fromMap({
      "name": name,
      "email": email,
      "username": username,
      "password": password,
      "avatar": avatar != '' ? await MultipartFile.fromFile(avatar!) : null,
      "role": "customer"
    });
    var response = await dio.post('/user', data: formData);

    if (response.statusCode == 200) {
      CustomerResponse cusRes = CustomerResponse(
          responStatus: ResponStatus.fromJson(response.data['respon_status']),
          data: Data.fromJson(response.data['data']));
      return cusRes;
    }
    CustomerResponse cusRes = CustomerResponse(
        responStatus: ResponStatus.fromJson(response.data['respon_status']));
    return cusRes;
  }
}
