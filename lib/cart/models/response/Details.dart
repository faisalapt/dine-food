import 'Menu.dart';

class Details {
  int? id;
  String? menuId;
  Menu? menu;
  int? qty;
  int flag = 0;

  Details({this.id, this.menuId, this.menu, this.qty});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    menuId = json['menu_id'];
    menu = json['menu'] != null ? new Menu.fromJson(json['menu']) : null;
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['menu_id'] = this.menuId;
    data['qty'] = this.qty;
    data['flag'] = this.flag;
    if (this.menu != null) {
      data['menu'] = this.menu!.toJson();
    }
    return data;
  }
}
