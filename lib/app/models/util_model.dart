class UtilModel {
  int? id;
  String? titleEn;
  String? titleFr;
  String? titleAr;
  double? lat;
  double? long;

  UtilModel({this.id, this.titleAr, this.titleEn, this.titleFr, this.lat, this.long});

  UtilModel.fromJson(Map<String, dynamic> json) {
    print(json);
    id = json['id'];
    titleEn = json['titleEn'];
    titleFr = json['titleFr'];
    titleAr = json['titleAr'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['titleEn'] = titleEn;
    data['titleFr'] = titleFr;
    data['titleAr'] = titleAr;
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}
