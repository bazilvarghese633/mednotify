// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'testappointment.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TestAppointmentAdapter extends TypeAdapter<TestAppointment> {
  @override
  final int typeId = 2;

  @override
  TestAppointment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TestAppointment(
      testName: fields[0] as String,
      laboratoryName: fields[1] as String,
      date: fields[2] as DateTime,
      time: fields[3] as TimeOfDay,
      images: (fields[4] as List).cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, TestAppointment obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.testName)
      ..writeByte(1)
      ..write(obj.laboratoryName)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.images);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TestAppointmentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
