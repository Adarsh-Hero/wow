class GeoPoint {
  String lat;
  String lng;

  GeoPoint({this.lat, this.lng});

  factory GeoPoint.fromMap(map) {
    if (map != null) {
      return GeoPoint(
        lat: map['lat'] ?? '',
        lng: map['lng'] ?? '',
      );
    }
    return GeoPoint();
  }
}