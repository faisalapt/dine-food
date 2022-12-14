import 'package:dine_food/home/ApiCheckToken.dart';
import 'package:dine_food/home/customer/UI/HomeCustomerSCreen.dart';
import 'package:dine_food/home/customer/UI/HomeCustomerWidget.dart';
import 'package:dine_food/home/partner/UI/HomePartner.dart';
import 'package:dine_food/utils/ApiUtils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../login/UI/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool? isLogin;

  @override
  void initState() {
    // TODO: implement initState
    checkLogin();
    super.initState();
  }

  void checkLogin() async {
    var utils = ApiUtils();
    utils.mPreferences = await SharedPreferences.getInstance();

    isLogin = utils.mPreferences!.getBool('isLogin') ?? false;
    String? role = utils.mPreferences!.getString("role") ?? '';

    if (isLogin == false || isLogin == null) {
      Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
    } else {
      if (role == 'customer') {
        var response = ApiCheckToken().checkToken();

        await response.whenComplete(() async {
          await response.then((value) {
            if (value.statusCode == 401) {
              utils.mPreferences!.remove("name");
              utils.mPreferences!.remove("role");
              utils.mPreferences!.remove("token");
              utils.mPreferences!.remove("isLogin");
              utils.mPreferences!.remove("id");
              Navigator.pushNamedAndRemoveUntil(
                  context, "/home-page", (route) => false);
            } else if (value.statusCode == 200) {
              Navigator.pushNamedAndRemoveUntil(
                  context, "/home", (route) => false);
            }
          });
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
