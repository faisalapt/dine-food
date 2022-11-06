class User {
  String? id;
  String? globalId;
  String? initialName;
  String? name;
  String? email;
  String? username;
  String? avatar;
  String? role;

  User(
      {this.id,
      this.globalId,
      this.initialName,
      this.name,
      this.email,
      this.username,
      this.avatar,
      this.role});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    globalId = json['global_id'];
    initialName = json['initial_name'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    avatar = json['avatar'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['global_id'] = this.globalId;
    data['initial_name'] = this.initialName;
    data['name'] = this.name;
    data['email'] = this.email;
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    data['role'] = this.role;
    return data;
  }
}
