import 'package:hive/hive.dart';

part 'test_history.g.dart'; // Required for the generated adapter

@HiveType(typeId: 4) // Ensure typeId is unique
class TestHistory extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String testName;

  @HiveField(2)
  final DateTime testDate;

  @HiveField(3)
  final String results;

  TestHistory({
    required this.id,
    required this.testName,
    required this.testDate,
    required this.results,
  });
}
