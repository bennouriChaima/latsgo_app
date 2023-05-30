import 'package:urban_app/app/models/user_model.dart';

class ReservationModel {
  String? id;
  String? date;
  String? status;
  double? totalPrice;
  int? reservedSeats;
  UserModel? passenger;

  ReservationModel({this.id, this.passenger, this.reservedSeats, this.date, this.status, this.totalPrice});

  ReservationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    status = json['status'];
    totalPrice = double.parse(json['totalPrice'].toString());
    reservedSeats = int.parse(json['reservedSeats'].toString());
    json['passenger'] != null ? passenger = UserModel.fromJson(json['passenger'] as Map<String, dynamic>) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date;
    data['status'] = status;
    data['totalPrice'] = totalPrice;
    data['reservedSeats'] = reservedSeats;
    data['passenger'] = passenger?.toJson();
    return data;
  }
}
