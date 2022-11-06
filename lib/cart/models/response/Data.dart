import 'Record.dart';

class Data {
  Record? record;

  Data({this.record});

  Data.fromJson(Map<String, dynamic> json) {
    record =
        json['record'] != null ? new Record.fromJson(json['record']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.record != null) {
      data['record'] = this.record!.toJson();
    }
    return data;
  }
}
