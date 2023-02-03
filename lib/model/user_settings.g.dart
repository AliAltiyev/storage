// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_settings.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserSettingsModelAdapter extends TypeAdapter<UserSettingsModel> {
  @override
  final int typeId = 0;

  @override
  UserSettingsModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserSettingsModel(
      userName: fields[0] as String,
      sex: fields[1] as Sex,
      color: (fields[2] as List).cast<String>(),
      darkTheme: fields[3] as bool,
      light: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserSettingsModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.userName)
      ..writeByte(1)
      ..write(obj.sex)
      ..writeByte(2)
      ..write(obj.color)
      ..writeByte(3)
      ..write(obj.darkTheme)
      ..writeByte(4)
      ..write(obj.light);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSettingsModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
