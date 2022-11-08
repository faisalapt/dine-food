import 'Menu.dart';

class Details {
  int? id;
  int? qty;
  int? price;
  Menu? menu;

  Details({this.id, this.qty, this.price, this.menu});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    qty = json['qty'];
    price = json['price'];
    menu = json['menu'] != null ? new Menu.fromJson(json['menu']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['qty'] = this.qty;
    data['price'] = this.price;
    if (this.menu != null) {
      data['menu'] = this.menu!.toJson();
    }
    return data;
  }
}
