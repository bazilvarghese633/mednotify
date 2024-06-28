import 'package:hive/hive.dart';

part 'medicine_model.g.dart';

@HiveType(typeId: 1)
class Medicine {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String medicineName;
  @HiveField(2)
  String medicineUnit;
  @HiveField(3)
  String frequency;
  @HiveField(4)
  String? selectedDate;
  @HiveField(5)
  String? selectedDay;
  @HiveField(6)
  String? endDate;
  @HiveField(7)
  String whenm;
  @HiveField(8)
  String dosage;
  @HiveField(9)
  String notifications;
  @HiveField(10)
  String startdate;
  @HiveField(11)
  String enddate;
  @HiveField(12)
  String currentstock;
  @HiveField(13)
  String destock;

  Medicine({
    required this.id,
    required this.medicineName,
    required this.medicineUnit,
    required this.frequency,
    this.selectedDate,
    this.selectedDay,
    this.endDate,
    required this.whenm,
    required this.dosage,
    required this.notifications,
    required this.startdate,
    required this.enddate,
    required this.currentstock,
    required this.destock,
  });
}
