class Menu {
  String? id;
  String? name;
  int? price;
  bool? isReady;
  String? image;
  String? storeId;

  Menu(
      {this.id, this.name, this.price, this.isReady, this.image, this.storeId});

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    price = json['price'];
    isReady = json['is_ready'];
    image = json['image'];
    storeId = json['store_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['price'] = this.price;
    data['is_ready'] = this.isReady;
    data['image'] = this.image;
    data['store_id'] = this.storeId;
    return data;
  }
}
