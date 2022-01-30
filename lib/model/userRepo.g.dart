// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userRepo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserRepoAdapter extends TypeAdapter<UserRepo> {
  @override
  final int typeId = 0;

  @override
  UserRepo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserRepo(
      owner: fields[4] as Owner,
      description: fields[3] as String,
      fullName: fields[2] as String,
      id: fields[0] as int,
      name: fields[1] as String,
      language: fields[5] as String,
      forksCount: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, UserRepo obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.fullName)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.owner)
      ..writeByte(5)
      ..write(obj.language)
      ..writeByte(6)
      ..write(obj.forksCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserRepoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
