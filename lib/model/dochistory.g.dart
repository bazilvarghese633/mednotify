// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dochistory.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DoctorHistoryAdapter extends TypeAdapter<DoctorHistory> {
  @override
  final int typeId = 5;

  @override
  DoctorHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DoctorHistory(
      id: fields[0] as String,
      doctorName: fields[1] as String,
      appointmentDate: fields[2] as DateTime,
      hospitalName: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DoctorHistory obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.doctorName)
      ..writeByte(2)
      ..write(obj.appointmentDate)
      ..writeByte(3)
      ..write(obj.hospitalName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoctorHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
