import 'package:equatable/equatable.dart';

class Customer extends Equatable {
  String? id;
  String? name;
  String? role;
  String? avatar;
  String? username;
  String? email;

  Customer(
      {this.name, this.id, this.avatar, this.role, this.username, this.email});

  @override
  List<Object?> get props => [id, name, role, avatar, username, email];

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];

    name = json['name'];
    email = json['email'];
    username = json['username'];
    avatar = json['avatar'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    data['role'] = this.role;
    return data;
  }
}
