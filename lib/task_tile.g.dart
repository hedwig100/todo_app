// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_tile.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskTileAdapter extends TypeAdapter<TaskTile> {
  @override
  final int typeId = 2;

  @override
  TaskTile read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskTile(
      fields[0] as IconData,
      fields[1] as String,
      (fields[2] as List).cast<Task>(),
    );
  }

  @override
  void write(BinaryWriter writer, TaskTile obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.icon)
      ..writeByte(1)
      ..write(obj.listName)
      ..writeByte(2)
      ..write(obj.tasks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskTileAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
