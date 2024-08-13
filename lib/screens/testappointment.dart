import 'package:flutter/material.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:medicine_try1/model/testappointment.dart';
import 'package:medicine_try1/screens/add_test.dart';
import 'package:medicine_try1/screens/viewtest.dart';
import '../ui_colors/green.dart';

class TestAppointmentScreen extends StatefulWidget {
  const TestAppointmentScreen({super.key});

  @override
  State<TestAppointmentScreen> createState() => _TestAppointmentScreenState();
}

class _TestAppointmentScreenState extends State<TestAppointmentScreen> {
  late Box<TestAppointment> _appointmentsBox;
  late ValueNotifier<List<TestAppointment>> _appointmentsNotifier;

  @override
  void initState() {
    super.initState();
    _appointmentsBox = Hive.box<TestAppointment>('testAppointmentsBox');
    _appointmentsNotifier = ValueNotifier([]);
    _loadAppointments(); // Initial load and sort
    _appointmentsBox.watch().listen((event) {
      _loadAppointments(); // Reload and sort on change
    });
  }

  @override
  void dispose() {
    _appointmentsNotifier.dispose();
    super.dispose();
  }

  Future<void> _loadAppointments() async {
    final appointments = _appointmentsBox.values.toList();
    appointments.sort((a, b) {
      // Compare by date first
      int dateComparison = a.date.compareTo(b.date);
      if (dateComparison != 0) return dateComparison;

      // If dates are the same, compare by time
      return _timeOfDayToMinutes(a.time).compareTo(_timeOfDayToMinutes(b.time));
    });
    _appointmentsNotifier.value = appointments;
  }

  int _timeOfDayToMinutes(TimeOfDay time) {
    return time.hour * 60 + time.minute;
  }

  void _addAppointment(TestAppointment testAppointment) async {
    await _appointmentsBox.add(testAppointment);
    _loadAppointments(); // Reload and sort appointments
  }

  void _deleteAppointment(int index) async {
    await _appointmentsBox.deleteAt(index);
    _loadAppointments(); // Reload and sort appointments
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 227, 226, 226),
        title: Center(
          child: Text(
            'Test Appointments       ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: ValueListenableBuilder<List<TestAppointment>>(
        valueListenable: _appointmentsNotifier,
        builder: (context, testAppointments, _) {
          return testAppointments.isEmpty
              ? Center(child: Text("No Test Appointments"))
              : ListView.builder(
                  itemCount: testAppointments.length,
                  itemBuilder: (context, index) {
                    final testAppointment = testAppointments[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(
                            width: 2,
                            color: greencolor,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 5, top: 10, bottom: 10, right: 5),
                          child: ListTile(
                            title: Text(
                              "Test: ${testAppointment.testName}",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                                'Date: ${DateFormat('dd-MM-yyyy').format(testAppointment.date)}\nTime: ${testAppointment.time.format(context)}'),
                            leading: Icon(
                              IcoFontIcons.laboratory,
                              color: Color.fromARGB(255, 244, 54, 203),
                              size: 40,
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ViewTestAppointmentScreen(
                                    testAppointment: testAppointment,
                                    appointmentIndex: index,
                                  ),
                                ),
                              );
                            },
                            trailing: IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () => _deleteAppointment(index),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: greencolor,
        onPressed: () async {
          final newAppointment = await Navigator.push<TestAppointment>(
            context,
            MaterialPageRoute(
              builder: (context) => TestAppointmentAdd(onSave: _addAppointment),
            ),
          );

          // Call _addAppointment to ensure the list is updated
          if (newAppointment != null) {
            _addAppointment(newAppointment);
          }
        },
        label: Row(
          children: [
            Icon(Icons.add),
            SizedBox(width: 8),
            Text(
              "Add",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
