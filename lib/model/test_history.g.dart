// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_history.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TestHistoryAdapter extends TypeAdapter<TestHistory> {
  @override
  final int typeId = 4;

  @override
  TestHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TestHistory(
      id: fields[0] as String,
      testName: fields[1] as String,
      testDate: fields[2] as DateTime,
      results: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TestHistory obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.testName)
      ..writeByte(2)
      ..write(obj.testDate)
      ..writeByte(3)
      ..write(obj.results);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
