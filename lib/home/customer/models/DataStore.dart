import 'package:equatable/equatable.dart';

import 'Stores.dart';

class DataStore extends Equatable {
  List<Stores>? stores;

  DataStore({this.stores});

  DataStore.fromJson(Map<String, dynamic> json) {
    if (json['records'] != null) {
      stores = <Stores>[];
      json['records'].forEach((v) {
        stores!.add(new Stores.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.stores != null) {
      data['records'] = this.stores!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  List<Object?> get props => [stores];
}
