import 'package:urban_app/app/models/car_model.dart';

class UserModel {
  String? id;
  String? firstName;
  String? lastName;
  DateTime? birthday;
  String? type;
  String? gender;
  String? deviceToken;
  String? phone;
  CarModel? car;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.birthday,
    this.type,
    this.gender,
    this.deviceToken,
    this.phone,
    this.car,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    print('user json:::  ${json}');
    id = json['id'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    birthday = DateTime.parse(json['birthday']);
    type = json['type'];
    gender = json['gender'];
    deviceToken = json['deviceToken'];
    phone = json['phone'];
    if (json['car'] != null) {
      car = CarModel.fromJson(json['car'] as Map<String, dynamic>);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['birthday'] = birthday.toString();
    data['type'] = type;
    data['gender'] = gender;
    data['deviceToken'] = deviceToken;
    data['phone'] = phone;
    if (car != null) {
      data['car'] = car!.toJson();
    }
    return data;
  }
}
