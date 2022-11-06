import 'Data.dart';
import 'Errors.dart';
import 'ResponStatus.dart';

class Login {
  ResponStatus? responStatus;
  Data? data;
  Errors? errors;

  Login({this.responStatus, this.data, this.errors});

  Login.fromJson(Map<String, dynamic> json) {
    responStatus = json['respon_status'] != null
        ? new ResponStatus.fromJson(json['respon_status'])
        : null;
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    errors =
        json['errors'] != null ? new Errors.fromJson(json['errors']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.responStatus != null) {
      data['respon_status'] = this.responStatus!.toJson();
    }
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (this.errors != null) {
      data['errors'] = this.errors!.toJson();
    }
    return data;
  }
}
