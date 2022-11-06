class Errors {
  List<String>? name;
  List<String>? email;
  List<String>? username;
  List<String>? password;

  Errors({this.name, this.email, this.username, this.password});

  Errors.fromJson(Map<String, dynamic> json) {
    name = json['name'].cast<String>();
    email = json['email'].cast<String>();
    username = json['username'].cast<String>();
    password = json['password'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}
