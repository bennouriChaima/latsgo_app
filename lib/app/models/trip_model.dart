import 'package:urban_app/app/models/reservation_model.dart';
import 'package:urban_app/app/models/user_model.dart';
import 'package:urban_app/app/models/util_model.dart';

class TripModel {
  String? id;
  String? driverId;
  int? numberOfSeats;
  int? reservedSeats;
  bool? onlyWomen;
  double? price;
  String? startingDate;
  String? startingTime;
  String? type;
  String? description;
  UserModel? driver;
  UtilModel? staringPoint;
  UtilModel? arivalPoint;
  List<ReservationModel>? reservations;
  List<String>? reservationsPassengers;
  String? status;

  TripModel({
    this.id,
    this.onlyWomen,
    this.numberOfSeats,
    this.reservedSeats,
    this.startingDate,
    this.driver,
    this.type,
    this.price,
    this.description,
    this.startingTime,
    this.arivalPoint,
    this.driverId,
    this.staringPoint,
    this.reservations,
    this.reservationsPassengers,
    this.status,
  });

  TripModel.fromJson(Map<String, dynamic> json, String tripId) {
    id = tripId;
    driverId = json['driverId'];
    status = json['status'];
    numberOfSeats = int.parse(json['numberOfSeats'].toString());
    reservedSeats = json['reservedSeats'] != null ? int.parse(json['reservedSeats'].toString()) : 0;
    onlyWomen = json['onlyWomen'];
    price = double.parse(json['price'].toString());
    startingDate = json['startingDate'];
    startingTime = json['startingTime'];
    type = json['type'];
    description = json['description'];
    json['driver'] != null ? driver = UserModel.fromJson(json['driver'] as Map<String, dynamic>) : null;
    json['startingPoint'] != null
        ? staringPoint = UtilModel.fromJson(json['startingPoint'] as Map<String, dynamic>)
        : null;
    json['arivalPoint'] != null ? arivalPoint = UtilModel.fromJson(json['arivalPoint'] as Map<String, dynamic>) : null;
    if (json['reservations'] != null) {
      reservations = [];
      json['reservations'].forEach((item) {
        reservations?.add(ReservationModel.fromJson(item as Map<String, dynamic>));
      });
    }
    if (json['reservationsPassengers'] != null) {
      reservationsPassengers = [];
      json['reservationsPassengers'].forEach((item) {
        reservationsPassengers?.add(item.toString());
      });
    }
  }
}
