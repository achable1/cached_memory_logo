// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_adapters.dart';

// **************************************************************************
// AdaptersGenerator
// **************************************************************************

class LogoTableAdapter extends TypeAdapter<LogoTable> {
  @override
  final typeId = 0;

  @override
  LogoTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LogoTable(
      path: fields[0] as String,
      imageBase64: fields[1] as String,
      monthSaved: (fields[2] as num).toInt(),
    );
  }

  @override
  void write(BinaryWriter writer, LogoTable obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.path)
      ..writeByte(1)
      ..write(obj.imageBase64)
      ..writeByte(2)
      ..write(obj.monthSaved);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LogoTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
