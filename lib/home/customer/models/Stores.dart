import 'package:equatable/equatable.dart';

class Stores extends Equatable {
  String? id;
  String? name;
  String? address;
  String? postalCode;
  String? logo;
  Null? lat;
  Null? lng;

  Stores(
      {this.id,
      this.name,
      this.address,
      this.postalCode,
      this.logo,
      this.lat,
      this.lng});

  Stores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    address = json['address'];
    postalCode = json['postal_code'];
    logo = json['logo'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['address'] = this.address;
    data['postal_code'] = this.postalCode;
    data['logo'] = this.logo;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }

  @override
  List<Object?> get props => [id, name, address, postalCode, logo];
}
