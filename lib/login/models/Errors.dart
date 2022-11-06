class Errors {
  List<String>? identify;
  List<String>? password;

  Errors({this.identify, this.password});

  Errors.fromJson(Map<String, dynamic> json) {
    identify = json['identify'].cast<String>();
    password = json['password'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identify'] = this.identify;
    data['password'] = this.password;
    return data;
  }
}
