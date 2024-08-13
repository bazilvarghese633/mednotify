import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'testappointment.g.dart'; // The file name for the generated adapter

@HiveType(typeId: 2)
class TestAppointment {
  @HiveField(0)
  final String testName;

  @HiveField(1)
  final String laboratoryName;

  @HiveField(2)
  final DateTime date;

  @HiveField(3)
  final TimeOfDay time;

  @HiveField(4)
  final List<String> images;

  TestAppointment({
    required this.testName,
    required this.laboratoryName,
    required this.date,
    required this.time,
    required this.images,
  });
}

// Create a custom type adapter for TimeOfDay
class TimeOfDayAdapter extends TypeAdapter<TimeOfDay> {
  @override
  final typeId = 3;

  @override
  TimeOfDay read(BinaryReader reader) {
    final hour = reader.readInt();
    final minute = reader.readInt();
    return TimeOfDay(hour: hour, minute: minute);
  }

  @override
  void write(BinaryWriter writer, TimeOfDay obj) {
    writer.writeInt(obj.hour);
    writer.writeInt(obj.minute);
  }
}
