// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medicine_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MedicineAdapter extends TypeAdapter<Medicine> {
  @override
  final int typeId = 1;

  @override
  Medicine read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Medicine(
      id: fields[0] as String?,
      medicineName: fields[1] as String,
      medicineUnit: fields[2] as String,
      frequency: fields[3] as String,
      selectedDate: fields[4] as String?,
      selectedDay: fields[5] as String?,
      endDate: fields[6] as String?,
      whenm: fields[7] as String,
      dosage: fields[8] as String,
      notifications: fields[9] as String,
      startdate: fields[10] as String,
      enddate: fields[11] as String,
      currentstock: fields[12] as String,
      destock: fields[13] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Medicine obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.medicineName)
      ..writeByte(2)
      ..write(obj.medicineUnit)
      ..writeByte(3)
      ..write(obj.frequency)
      ..writeByte(4)
      ..write(obj.selectedDate)
      ..writeByte(5)
      ..write(obj.selectedDay)
      ..writeByte(6)
      ..write(obj.endDate)
      ..writeByte(7)
      ..write(obj.whenm)
      ..writeByte(8)
      ..write(obj.dosage)
      ..writeByte(9)
      ..write(obj.notifications)
      ..writeByte(10)
      ..write(obj.startdate)
      ..writeByte(11)
      ..write(obj.enddate)
      ..writeByte(12)
      ..write(obj.currentstock)
      ..writeByte(13)
      ..write(obj.destock);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MedicineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
