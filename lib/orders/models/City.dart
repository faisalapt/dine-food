class City {
  String? id;
  String? name;
  String? provinceId;

  City({this.id, this.name, this.provinceId});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    provinceId = json['province_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['province_id'] = this.provinceId;
    return data;
  }
}
