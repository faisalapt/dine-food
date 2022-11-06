import 'Records.dart';

class Data {
  Store? records;

  Data({this.records});

  Data.fromJson(Map<String, dynamic> json) {
    records =
        json['records'] != null ? new Store.fromJson(json['records']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.records != null) {
      data['records'] = this.records!.toJson();
    }
    return data;
  }
}
