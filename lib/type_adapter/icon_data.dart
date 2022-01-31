import "package:hive/hive.dart";
import "package:flutter/material.dart";

class IconDataAdapter extends TypeAdapter<IconData> {
  @override
  final typeId = 4;

  @override
  IconData read(BinaryReader reader) {
    final codepoint = reader.readInt();
    return IconData(codepoint);
  }

  @override
  void write(BinaryWriter writer, IconData obj) {
    writer.writeInt(obj.codePoint);
  }
}
