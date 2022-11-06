import 'dart:io';

import 'package:dine_food/login/service/api.dart';
import 'package:dine_food/register/partner/models/city/Records.dart';
import 'package:dine_food/register/partner/models/partner/PartnerRequest.dart';
import 'package:dine_food/register/partner/service/api.dart';
import 'package:dine_food/utils/ApiUtils.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PartnerData extends StatefulWidget {
  const PartnerData(
      {super.key,
      required this.name,
      required this.email,
      required this.password,
      required this.username,
      this.avatar});
  final String name;
  final String username;
  final String password;
  final String email;
  final String? avatar;

  @override
  State<PartnerData> createState() => _PartnerDataState();
}

class _PartnerDataState extends State<PartnerData> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController teStoreName = TextEditingController();
  TextEditingController teAddress = TextEditingController();
  TextEditingController tePostal = TextEditingController();
  TextEditingController teSearch = TextEditingController();
  int? city_id;

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
    teSearch.dispose();
    tePostal.dispose();
    teAddress.dispose();
    teStoreName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2A363B),
      appBar: AppBar(
        backgroundColor: Color(0xff2A363B),
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
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.13,
                  ),
                  Text(
                    "Register your store",
                    style: TextStyle(
                        fontFamily: "Cocogoose-Regular",
                        fontSize: 36,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.06,
                  ),
                  TextFormField(
                    controller: teStoreName,
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
                      hintText: "Store Name",
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
                  DropdownSearch<RecordsCity>(
                    validator: (RecordsCity? city) {
                      if (city == null) {
                        return "Field is Required";
                      }
                      return null;
                    },
                    asyncItems: (String filter) async {
                      var response = await ApiUtils()
                          .dio
                          .get('/city/get-options', queryParameters: {
                        "q": filter.isNotEmpty ? filter : ''
                      });
                      var models = RecordsCity()
                          .fromJsonList(response.data['data']['records']);
                      return models!;
                    },
                    itemAsString: (RecordsCity city) => city.cityAsString(),
                    onChanged: (RecordsCity? city) {
                      city_id = int.parse(city!.getValue());
                    },
                    popupProps: PopupProps.modalBottomSheet(
                        fit: FlexFit.loose,
                        modalBottomSheetProps: ModalBottomSheetProps(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                        ),
                        showSearchBox: true,
                        searchFieldProps: TextFieldProps(controller: teSearch)),
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        hintText: "City",
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
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: teAddress,
                    decoration: InputDecoration(
                      hintText: "Address",
                      hintStyle: TextStyle(fontFamily: "Cocogoose-Thin"),
                      counterText: '',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Color(0xfff3f3f4),
                      filled: true,
                    ),
                    keyboardType: TextInputType.streetAddress,
                    minLines: 3,
                    maxLines: 5,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: tePostal,
                    decoration: InputDecoration(
                      hintText: "Postal Code",
                      hintStyle: TextStyle(fontFamily: "Cocogoose-Thin"),
                      counterText: '',
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      fillColor: Color(0xfff3f3f4),
                      filled: true,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Choose Logo Store",
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
                                  MaterialStateProperty.all(Color(0xff99B898)),
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
                              PartnerRequest request = PartnerRequest(
                                  name: widget.name,
                                  email: widget.email,
                                  username: widget.username,
                                  password: widget.password,
                                  address: teAddress.text,
                                  name_store: teStoreName.text,
                                  city_id: city_id!,
                                  postal: tePostal.text,
                                  avatar: widget.avatar,
                                  logo_store: imagesPick != null
                                      ? imagesPick!.path
                                      : '');
                              var response =
                                  ApiRegisterPartner().registerPartner(request);
                              response.then((value) {
                                if (value.responStatus!.code == 200) {
                                  var res = ApiLogin()
                                      .login(widget.username, widget.password);
                                  res.then((val) async {
                                    if (val.responStatus!.code == 200) {
                                      mPreference =
                                          await SharedPreferences.getInstance();
                                      mPreference.setString(
                                          "name", val.data!.user!.name!);
                                      mPreference.setString(
                                          "role", val.data!.user!.role!);
                                      mPreference.setString("token",
                                          val.data!.token!.accessToken!);
                                      mPreference.setBool("isLogin", true);
                                      mPreference.setString(
                                          "id", val.data!.user!.id!);
                                    }
                                  });
                                }
                              });
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 10),
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                      color: Color(0xff2A363B),
                                      fontFamily: "Cocogoose-Regular"),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
