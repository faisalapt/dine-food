import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

class CustomerRequest extends Equatable {
  final String name;
  final String email;
  final String username;
  final String password;
  final XFile? avatar;

  const CustomerRequest(
      {this.avatar,
      required this.email,
      required this.name,
      required this.username,
      required this.password});

  CustomerRequest copyWith(
      {String? name,
      String? email,
      String? username,
      String? password,
      XFile? avatar}) {
    return CustomerRequest(
        avatar: avatar ?? this.avatar,
        email: email ?? this.email,
        name: name ?? this.name,
        username: username ?? this.username,
        password: password ?? this.password);
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "username": username,
        "password": password,
        "avatar": avatar,
        "role": "cutomer"
      };

  @override
  List<Object?> get props => [name, email, username, password, avatar];
}
