import 'City.dart';
import 'Menu.dart';

class Store {
  String? id;
  String? name;
  String? address;
  String? postalCode;
  String? logo;
  City? city;
  List<Menu>? menu;

  Store(
      {this.id,
      this.name,
      this.address,
      this.postalCode,
      this.logo,
      this.city,
      this.menu});

  Store.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    postalCode = json['postal_code'];
    logo = json['logo'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    if (json['menu'] != null) {
      menu = <Menu>[];
      json['menu'].forEach((v) {
        menu!.add(new Menu.fromJson(v));
      });
    }
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
    if (this.menu != null) {
      data['menu'] = this.menu!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
