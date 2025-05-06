// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserTableAdapter extends TypeAdapter<UserTable> {
  @override
  final int typeId = 0;

  @override
  UserTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserTable()
      ..document = fields[0] as String
      ..year = fields[1] as String?
      ..name = fields[2] as String?
      ..session = fields[3] as String?;
  }

  @override
  void write(BinaryWriter writer, UserTable obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.document)
      ..writeByte(1)
      ..write(obj.year)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.session);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
