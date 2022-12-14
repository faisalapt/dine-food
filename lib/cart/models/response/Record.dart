import 'Details.dart';
import 'Store.dart';
import 'User.dart';

class Record {
  String? id;
  String? storeId;
  Store? store;
  User? user;
  List<Details>? details;

  Record({this.id, this.storeId, this.store, this.details, this.user});

  Record.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    storeId = json['store_id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
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
    data['store_id'] = this.storeId;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.store != null) {
      data['store'] = this.store!.toJson();
    }
    if (this.details != null) {
      data['details'] = this.details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
