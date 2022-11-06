import 'Records.dart';

class Data {
  List<RecordsCity>? records;
  List<String>? data;

  Data({this.records, this.data});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      records = <RecordsCity>[];
      json['records'].forEach((v) {
        records!.add(new RecordsCity.fromJson(v));
      });
      data = [];
      json['records'].forEach((v) {
        data!.add(v['full_text']);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.records != null) {
      data['records'] = this.records!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
