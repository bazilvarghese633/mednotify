import 'package:hive/hive.dart';

part 'dochistory.g.dart'; // Required for the generated adapter

@HiveType(typeId: 5) // Ensure typeId is unique
class DoctorHistory extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String doctorName;

  @HiveField(2)
  final DateTime appointmentDate;

  @HiveField(3)
  final String hospitalName;

  DoctorHistory({
    required this.id,
    required this.doctorName,
    required this.appointmentDate,
    required this.hospitalName,
  });
}
