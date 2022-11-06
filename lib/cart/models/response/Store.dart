import 'City.dart';

class Store {
  String? id;
  String? name;
  String? address;
  String? postalCode;
  String? logo;
  City? city;

  Store(
      {this.id,
      this.name,
      this.address,
      this.postalCode,
      this.logo,
      this.city});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    postalCode = json['postal_code'];
    logo = json['logo'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['postal_code'] = this.postalCode;
    data['logo'] = this.logo;
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    return data;
  }
}
