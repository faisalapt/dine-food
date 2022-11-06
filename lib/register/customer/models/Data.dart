class Data {
  String? id;
  String? name;
  String? email;
  String? username;
  String? role;
  String? avatar;
  String? updatedAt;
  String? createdAt;

  Data(
      {this.id,
      this.name,
      this.email,
      this.username,
      this.role,
      this.avatar,
      this.updatedAt,
      this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    role = json['role'];
    avatar = json['avatar'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['username'] = this.username;
    data['role'] = this.role;
    data['avatar'] = this.avatar;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}
