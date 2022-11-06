import 'dart:convert';
import 'dart:io';

import 'package:dine_food/login/models/Data.dart';
import 'package:dine_food/login/models/Errors.dart';
import 'package:dine_food/login/models/Login.dart';
import 'package:dine_food/login/models/ResponStatus.dart';
import 'package:dine_food/utils/ApiUtils.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiLogin extends ApiUtils {
  Future<Login> login(String identity, String password) async {
    var response = await dio.post(
      '/login',
      data: {"identify": identity, "password": password},
    );
    if (response.statusCode == 200) {
      Login dataLogin = Login(
        responStatus: ResponStatus.fromJson(response.data['respon_status']),
        data: Data.fromJson(response.data['data']),
      );
      mPreferences = await SharedPreferences.getInstance();
      mPreferences!.setString("name", dataLogin.data!.user!.name!);
      mPreferences!.setString("role", dataLogin.data!.user!.role!);
      mPreferences!.setString("token", dataLogin.data!.token!.accessToken!);
      mPreferences!.setString("id", dataLogin.data!.user!.id!);
      mPreferences!.setBool("isLogin", true);
      return dataLogin;
    }
    Login dataLogin = Login(
      responStatus: ResponStatus.fromJson(response.data['respon_status']),
    );

    return dataLogin;
  }
}
