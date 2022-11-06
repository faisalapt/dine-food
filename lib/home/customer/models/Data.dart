import 'Customer.dart';

class Data {
  Customer? customer;

  Data({this.customer});

  Data.fromJson(Map<String, dynamic> json) {
    customer =
        json['record'] != null ? new Customer.fromJson(json['record']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}
