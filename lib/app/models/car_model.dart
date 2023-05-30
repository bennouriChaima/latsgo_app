class CarModel {
  String? brand;
  String? model;
  String? plate;
  int? numberOfSeats;

  CarModel({
    this.brand,
    this.model,
    this.plate,
    this.numberOfSeats,
  });

  CarModel.fromJson(Map<String, dynamic> json) {
    print(json);
    brand = json['brand'];
    model = json['model'];
    plate = json['plate'].toString();
    numberOfSeats = int.parse(json['numberOfSeats'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['brand'] = brand;
    data['model'] = model;
    data['plate'] = plate;
    data['numberOfSeats'] = numberOfSeats;
    return data;
  }
}
