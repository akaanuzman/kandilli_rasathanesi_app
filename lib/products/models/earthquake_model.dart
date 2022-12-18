// ignore_for_file: unnecessary_this

class EarthquakeModel {
  num? mag;
  num? lng;
  num? lat;
  String? lokasyon;
  num? depth;
  List<num>? coordinates;
  String? title;
  String? rev;
  num? timestamp;
  String? dateStamp;
  String? date;
  String? hash;
  String? hash2;

  EarthquakeModel(
      {this.mag,
      this.lng,
      this.lat,
      this.lokasyon,
      this.depth,
      this.coordinates,
      this.title,
      this.rev,
      this.timestamp,
      this.dateStamp,
      this.date,
      this.hash,
      this.hash2});

  EarthquakeModel.fromJson(Map<String, dynamic> json) {
    mag = json['mag'];
    lng = json['lng'];
    lat = json['lat'];
    lokasyon = json['lokasyon'];
    depth = json['depth'];
    coordinates = json['coordinates'].cast<double>();
    title = json['title'];
    rev = json['rev'];
    timestamp = json['timestamp'];
    dateStamp = json['date_stamp'];
    date = json['date'];
    hash = json['hash'];
    hash2 = json['hash2'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mag'] = this.mag;
    data['lng'] = this.lng;
    data['lat'] = this.lat;
    data['lokasyon'] = this.lokasyon;
    data['depth'] = this.depth;
    data['coordinates'] = this.coordinates;
    data['title'] = this.title;
    data['rev'] = this.rev;
    data['timestamp'] = this.timestamp;
    data['date_stamp'] = this.dateStamp;
    data['date'] = this.date;
    data['hash'] = this.hash;
    data['hash2'] = this.hash2;
    return data;
  }
}
