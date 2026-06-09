import "package:hive_ce/hive_ce.dart";

import "../tables/logo_table.dart";

/// Logo table adapter to be a custom data to save internally
/// within hive data source
class LogoTableAdapter extends TypeAdapter<LogoTable> {
  @override
  int get typeId => 0;

  @override
  LogoTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };

    return LogoTable(
      path: fields[0] as String,
      saved: fields[3] as String,
      fileName: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LogoTable obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.path)
      ..writeByte(3)
      ..write(obj.saved)
      ..writeByte(4)
      ..write(obj.fileName);
  }
}
