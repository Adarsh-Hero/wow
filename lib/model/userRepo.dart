import 'dart:convert';

import 'package:istreamo/model/owner.dart';
import 'package:sqflite/sqflite.dart';
import 'owner.dart';
import 'company.dart';

List<UserRepo> usersFromJson(String str) =>
    List<UserRepo>.from(json.decode(str).map((x) => UserRepo.fromJson(x)));

String usersToJson(List<UserRepo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserRepo {
  int id;
  String name;
  String fullName;
  String description;
  Owner owner;
  String language;
  int forksCount;

  UserRepo(
      {this.owner,
      this.description,
      this.fullName,
      this.id,
      this.name,
      this.language,
      this.forksCount});

  factory UserRepo.fromJson(Map<String, dynamic> json,
          {isForDatabase = false}) =>
      UserRepo(
        id: json["id"] ?? 0,
        description: json["description"] ?? '',
        name: json["name"] ?? '',
        fullName: json['full_name'] ?? '',
        owner: isForDatabase
            ? Owner.fromMap(json['owner']).toString()
            : Owner.fromMap(json['owner']),
        language: json["language"] ?? '',
        forksCount: json["forks_count"] ?? '',
      );

  Map<String, dynamic> toJson({isSavingData = false}) => {
        "description": description,
        "id": id,
        "name": name,
        "owner": isSavingData ? owner.toString() : owner,
        "language": language,
        "forks_count": forksCount,
        "fullName": fullName,
      };

  // static Future<UserRepo> insert(Database db, UserRepo data) async {
  //   await db.insert('users', data.toJson(isSavingData: true));
  //   return data;
  // }
  //
  // static Future<List<Map<dynamic, dynamic>>> getItems(Database db,
  //     {String name, String id}) async {
  //   List<Map> maps =
  //       await db.query('users', where: "name LIKE ?", whereArgs: ['%$name%']);
  //   if (maps.isNotEmpty) {
  //     var users = <Map<dynamic, dynamic>>[];
  //     for (var i = 0; i < maps.length; i++) {
  //       users.add(maps[i]);
  //     }
  //     return users;
  //   }
  //   return [];
  // }
}
