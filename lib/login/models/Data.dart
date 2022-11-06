import 'Token.dart';
import 'User.dart';

class Data {
  User? user;
  Token? token;
  List<String>? scopes;

  Data({this.user, this.token, this.scopes});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    token = json['token'] != null ? new Token.fromJson(json['token']) : null;
    scopes = json['scopes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.token != null) {
      data['token'] = this.token!.toJson();
    }
    data['scopes'] = this.scopes;
    return data;
  }
}
