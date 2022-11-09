import 'dart:convert';

import 'package:dine_food/home/HomaPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Login.dart';
import 'package:dine_food/login/service/api.dart';
import 'package:dine_food/register/customer/UI/register_customer.dart';
import 'package:flutter/material.dart';
import '../../main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController teUsername = TextEditingController();
  TextEditingController tePassword = TextEditingController();
  bool _visiblePass = true;

  @override
  void dispose() {
    // TODO: implement dispose
    teUsername.dispose();
    tePassword.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    _visiblePass = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xff2A363B),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.13,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.12),
                  child: Column(
                    children: [
                      Text(
                        "Hello Again",
                        style: TextStyle(
                          fontFamily: "Cocogoose-Regular",
                          color: Colors.white,
                          fontSize: 36,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.019,
                      ),
                      Text(
                        "Welcome back you’ve been missed",
                        style: TextStyle(
                          fontFamily: "Cocogoose-Thin",
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2,
                      ),
                      TextFormField(
                        controller: teUsername,
                        obscureText: false,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter Username",
                          hintStyle: TextStyle(fontFamily: "Cocogoose-Thin"),
                          counterText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: Color(0xfff3f3f4),
                          filled: true,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      TextFormField(
                        controller: tePassword,
                        obscureText: _visiblePass,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "This field is required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Password",
                          hintStyle: TextStyle(fontFamily: "Cocogoose-Thin"),
                          counterText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: Color(0xfff3f3f4),
                          filled: true,
                          suffixIcon: IconButton(
                            icon: Icon(_visiblePass
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _visiblePass = !_visiblePass;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.09,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(),
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Kesalahan pada validasi'),
                              ),
                            );
                          }
                          final response = ApiLogin()
                              .login(teUsername.text, tePassword.text);
                          response.then((value) async {
                            if (value.responStatus?.code != 200) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      value.responStatus!.message.toString()),
                                ),
                              );
                            } else {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => HomePage()));
                            }
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 13),
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Text(
                              "Sign In",
                              style: TextStyle(
                                fontFamily: "Cocogoose-Regular",
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.06,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Not a member? ",
                                style: TextStyle(
                                  fontFamily: "Cocogoose-Thin",
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => RegisterCustomerScreen(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Register Now",
                                  style: TextStyle(
                                    fontFamily: "Cocogoose-Regular",
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
