import 'Details.dart';
import 'Store.dart';

class Records {
  String? id;
  String? orderNumber;
  int? total;
  String? status;
  String? storeId;
  String? date;
  Store? store;
  List<Details>? details;

  Records(
      {this.id,
      this.orderNumber,
      this.total,
      this.status,
      this.storeId,
      this.date,
      this.store,
      this.details});

  Records.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNumber = json['order_number'];
    total = json['total'];
    status = json['status'];
    storeId = json['store_id'];
    date = json['date'];
    store = json['store'] != null ? new Store.fromJson(json['store']) : null;
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_number'] = this.orderNumber;
    data['total'] = this.total;
    data['status'] = this.status;
    data['store_id'] = this.storeId;
    data['date'] = this.date;
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
