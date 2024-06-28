import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'appointment_model.g.dart';

@HiveType(typeId: 0)
class Appointment extends HiveObject {
  @HiveField(0)
  final String doctorName;

  @HiveField(1)
  final String hospitalName;

  @HiveField(2)
  final DateTime appointmentDate;

  @HiveField(3)
  final String appointmentTime; // Store as String

  Appointment({
    required this.doctorName,
    required this.hospitalName,
    required this.appointmentDate,
    required this.appointmentTime,
  });

  TimeOfDay get appointmentTimeOfDay {
    final List<String> timeParts = appointmentTime.split(':');
    final int hour = int.parse(timeParts[0]);
    final int minute = int.parse(timeParts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }
}
