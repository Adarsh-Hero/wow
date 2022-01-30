
import 'package:hive/hive.dart';
part 'owner.g.dart';

@HiveType(typeId: 1)
class Owner {

  @HiveField(0)
  String avatarUrl;

  Owner({this.avatarUrl});

  factory Owner.fromMap(map) {
    return Owner(avatarUrl: map['avatar_url'] ?? '');
  }
}
