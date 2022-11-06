import 'package:dine_food/utils/ApiUtils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePartner extends StatefulWidget {
  const HomePartner({super.key});

  @override
  State<HomePartner> createState() => _HomePartnerState();
}

class _HomePartnerState extends State<HomePartner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ElevatedButton(
        child: Text("Log Out"),
        onPressed: () async {
          var mPreferences = ApiUtils().mPreferences;
          mPreferences = await SharedPreferences.getInstance();
          mPreferences!.remove("name");
          mPreferences!.remove("role");
          mPreferences!.remove("token");
          mPreferences!.remove("isLogin");
          print(mPreferences!.getBool("isLogin"));
          Navigator.pushNamedAndRemoveUntil(
              context, "/home-page", (route) => false);
        },
      ),
    );
  }
}
