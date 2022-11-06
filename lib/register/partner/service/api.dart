import 'package:dine_food/register/partner/models/partner/PartnerRequest.dart';
import 'package:dine_food/register/partner/models/partner/PartnerResponse.dart';
import 'package:dio/dio.dart';

import '../models/city/Data.dart';
import '../models/ResponStatus.dart';
import 'package:dine_food/register/partner/models/city/CityOption.dart';
import 'package:dine_food/utils/ApiUtils.dart';

class ApiRegisterPartner extends ApiUtils {
  Future<CityOption> getCity() async {
    var response = await dio.get('/city/get-options');
    CityOption city = CityOption(
        responStatus: ResponStatus.fromJson(response.data['respon_status']),
        data: Data.fromJson(response.data['data']));
    return city;
  }

  Future<PartnerResponse> registerPartner(PartnerRequest request) async {
    FormData formData = FormData.fromMap({
      "name": request.name,
      "email": request.email,
      "password": request.password,
      "username": request.username,
      "avatar": request.avatar != ''
          ? await MultipartFile.fromFile(request.avatar!)
          : null,
      "role": "partner",
      "store_name": request.name_store,
      "store_address": request.address,
      "store_city": request.city_id,
      "store_postal": request.postal,
      "logo": request.logo_store != ''
          ? await MultipartFile.fromFile(request.logo_store!)
          : null
    });
    var response = await dio.post("/user", data: formData);

    PartnerResponse partnerResponse = PartnerResponse(
        responStatus: ResponStatus.fromJson(response.data['respon_status']));
    return partnerResponse;
  }
}
