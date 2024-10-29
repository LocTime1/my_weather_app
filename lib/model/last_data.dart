class LastData {
  int? id;
  double? lat;
  double? long;
  String? city;
  String? country;

  LastData({this.id, this.lat, this.long, this.city, this.country});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map['id'] = id;
    map['lat'] = lat;
    map['long'] = long;
    map['city'] = city;
    map['country'] = country;
    return map;
  }

  LastData.fromMap(Map<String, dynamic> map) {
    map['id'] = id;
    map['lat'] = lat;
    map['long'] = long;
    map['city'] = city;
    map['country'] = country;
  }
}