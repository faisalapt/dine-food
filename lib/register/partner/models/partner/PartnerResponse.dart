import '../ResponStatus.dart';

class PartnerResponse {
  ResponStatus? responStatus;

  PartnerResponse({this.responStatus});

  PartnerResponse.fromJson(Map<String, dynamic> json) {
    responStatus = json['respon_status'] != null
        ? new ResponStatus.fromJson(json['respon_status'])
        : null;
  }
}
