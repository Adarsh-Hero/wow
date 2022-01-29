import 'geo_point.dart';

class Owner {
  String avatarUrl;

  Owner({this.avatarUrl});

  factory Owner.fromMap(map) {
    return Owner(avatarUrl: map['zipcode'] ?? '');
  }
}
