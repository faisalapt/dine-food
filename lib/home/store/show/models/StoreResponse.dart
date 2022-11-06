import 'Data.dart';
import 'ResponStatus.dart';

class StoreResponse {
  ResponStatus? responStatus;
  Data? data;

  StoreResponse({this.responStatus, this.data});

  StoreResponse.fromJson(Map<String, dynamic> json) {
    responStatus = json['respon_status'] != null
        ? new ResponStatus.fromJson(json['respon_status'])
        : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.responStatus != null) {
      data['respon_status'] = this.responStatus!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
