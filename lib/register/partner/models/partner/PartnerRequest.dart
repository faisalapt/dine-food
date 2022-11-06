import 'package:dio/dio.dart';

class PartnerRequest {
  final String name;
  final String email;
  final String username;
  final String password;
  final String? avatar;
  final String name_store;
  final int city_id;
  final String address;
  final String postal;
  final String? logo_store;

  PartnerRequest(
      {required this.name,
      required this.email,
      required this.username,
      required this.password,
      required this.address,
      required this.name_store,
      required this.city_id,
      required this.postal,
      this.avatar,
      this.logo_store});
}
