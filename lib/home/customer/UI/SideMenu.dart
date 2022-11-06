import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  SharedPreferences? mPreference;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.08,
                ),
                ListTile(
                  leading: Icon(
                    Icons.account_box_rounded,
                    color: Colors.grey,
                  ),
                  title: Text("Profile"),
                  onTap: () {},
                ),
                ListTile(
                  leading: Icon(
                    Icons.shopping_cart_rounded,
                    color: Colors.grey,
                  ),
                  title: Text("Cart"),
                  onTap: () {
                    Navigator.pushNamed(context, "/cart");
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.history,
                    color: Colors.grey,
                  ),
                  title: Text("Orders"),
                  onTap: () {},
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.supervisor_account,
                    color: Colors.grey,
                  ),
                  title: Text("Log Out"),
                  onTap: () async {
                    mPreference = await SharedPreferences.getInstance();
                    mPreference!.remove("name");
                    mPreference!.remove("role");
                    mPreference!.remove("token");
                    mPreference!.remove("isLogin");
                    print(mPreference!.getBool("isLogin"));
                    Navigator.pushNamedAndRemoveUntil(
                        context, "/home-page", (route) => false);
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
