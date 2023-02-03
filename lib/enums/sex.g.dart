// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sex.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SexAdapter extends TypeAdapter<Sex> {
  @override
  final int typeId = 1;

  @override
  Sex read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Sex.MALE;
      case 1:
        return Sex.FEMALE;
      case 2:
        return Sex.OTHER;
      default:
        return Sex.MALE;
    }
  }

  @override
  void write(BinaryWriter writer, Sex obj) {
    switch (obj) {
      case Sex.MALE:
        writer.writeByte(0);
        break;
      case Sex.FEMALE:
        writer.writeByte(1);
        break;
      case Sex.OTHER:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SexAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
