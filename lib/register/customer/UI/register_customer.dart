import 'dart:io';

import 'package:dine_food/login/service/api.dart';
import 'package:dine_food/register/customer/models/CustomerRequest.dart';
import 'package:dine_food/register/customer/service/ApiRegister.dart';
import 'package:dine_food/register/partner/UI/register_partner.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterCustomerScreen extends StatefulWidget {
  const RegisterCustomerScreen({super.key});

  @override
  State<RegisterCustomerScreen> createState() => _RegisterCustomerScreenState();
}

class _RegisterCustomerScreenState extends State<RegisterCustomerScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController teName = TextEditingController();
  TextEditingController teEmail = TextEditingController();
  TextEditingController teUsername = TextEditingController();
  TextEditingController tePassword = TextEditingController();
  TextEditingController teConfirmPassword = TextEditingController();

  XFile? imagesPick;
  final ImagePicker picker = ImagePicker();

  late SharedPreferences mPreference;

  Future getImage(ImageSource source) async {
    var img = await picker.pickImage(source: source);

    setState(() {
      imagesPick = img;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    teConfirmPassword.dispose();
    teEmail.dispose();
    teName.dispose();
    tePassword.dispose();
    teUsername.dispose();
    super.dispose();
  }

  bool _visiblePass = true;
  bool _visibleConfPass = true;

  @override
  void initState() {
    // TODO: implement initState
    _visiblePass = true;
    _visibleConfPass = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff99B898),
      appBar: AppBar(
        backgroundColor: Color(0xff99B898),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.12,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.13,
                  ),
                  Text(
                    "Register",
                    style: TextStyle(
                      fontFamily: "Cocogoose-Regular",
                      color: Colors.white,
                      fontSize: 36,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Become a ",
                        style: TextStyle(
                          fontFamily: "Cocogoose-Thin",
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => RegisterPartner()));
                        },
                        child: Text(
                          "partner?",
                          style: TextStyle(
                            fontFamily: "Cocogoose-Regular",
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  TextFormField(
                    controller: teName,
                    obscureText: false,
                    keyboardType: TextInputType.name,
                    textCapitalization: TextCapitalization.words,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This field is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Full Name",
                      hintStyle: TextStyle(fontFamily: "Cocogoose-Thin"),
                      counterText: '',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Color(0xfff3f3f4),
                      filled: true,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: teEmail,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This field is required";
                      }
                      if (value!.length < 6) {
                        return "Password must be greater 6 character";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Email Address",
                      hintStyle: TextStyle(fontFamily: "Cocogoose-Thin"),
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Color(0xfff3f3f4),
                      filled: true,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: teUsername,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This field is required";
                      }
                      if (value!.length < 6) {
                        return "Username must be greater 6 character";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Username",
                      hintStyle: TextStyle(fontFamily: "Cocogoose-Thin"),
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Color(0xfff3f3f4),
                      filled: true,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: _visiblePass,
                    controller: tePassword,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This field is required";
                      }
                      if (value!.length < 6) {
                        return "Password must be greater 6 character";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(fontFamily: "Cocogoose-Thin"),
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
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
                    height: 20,
                  ),
                  TextFormField(
                    obscureText: _visibleConfPass,
                    controller: teConfirmPassword,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value != tePassword.text) {
                        return "Password does not match";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      hintStyle: TextStyle(fontFamily: "Cocogoose-Thin"),
                      counterText: '',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Color(0xfff3f3f4),
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(_visibleConfPass
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _visibleConfPass = !_visibleConfPass;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Choose profile picture",
                    style: TextStyle(
                      fontFamily: "Cocogoose-Thin",
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Container(
                        width: 102,
                        height: 102,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: imagesPick == null
                            ? CircleAvatar(
                                backgroundImage:
                                    AssetImage("assets/default-user.jpg"),
                              )
                            : CircleAvatar(
                                backgroundImage:
                                    FileImage(File(imagesPick!.path)),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Color(0xffFECEA8))),
                      onPressed: () {
                        getImage(ImageSource.gallery);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Choose Image",
                          style: TextStyle(
                            fontFamily: "Cocogoose-Regular",
                            color: Color(0xff99B898),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xff2A363B)),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (!_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Kesalahan pada validasi'),
                                  ),
                                );
                              }
                              var path =
                                  imagesPick != null ? imagesPick!.path : '';
                              final response = ApiRegister().register(
                                  teName.text,
                                  teEmail.text,
                                  teUsername.text,
                                  tePassword.text,
                                  path);
                              response.then((value) {
                                if (value.responStatus!.status != 200) {
                                  var loginResponse = ApiLogin()
                                      .login(teUsername.text, tePassword.text);
                                  loginResponse.then((val) async {
                                    if (val.responStatus!.code == 200) {
                                      mPreference =
                                          await SharedPreferences.getInstance();
                                      mPreference.setString(
                                          "name", val.data!.user!.name!);
                                      mPreference.setString(
                                          "role", val.data!.user!.role!);
                                      mPreference.setString("token",
                                          val.data!.token!.accessToken!);
                                      mPreference.setString(
                                          "id", val.data!.user!.id!);
                                      mPreference.setBool("isLogin", true);
                                    }
                                  });
                                }
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 10),
                              child: Row(
                                children: [
                                  Text(
                                    "Register",
                                    style: TextStyle(
                                      color: Color(0xff99B898),
                                      fontFamily: "Cocogoose-Regular",
                                      fontSize: 16,
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: Color(0xff99B898),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
