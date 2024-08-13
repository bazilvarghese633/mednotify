import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:medicine_try1/model/dochistory.dart';
import 'package:medicine_try1/model/test_history.dart';

// Main HistoryScreen with TabBar
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 227, 226, 226),
          title: const Center(
            child: Text(
              "History",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          bottom: const TabBar(
            indicatorColor: Color.fromARGB(255, 37, 226, 43),
            labelColor: Color.fromARGB(255, 37, 226, 43),
            unselectedLabelColor: Colors.grey,
            tabs: [
              Tab(text: "Doc Appointment History"),
              Tab(text: "Test Appointment History"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            DocAppointmentHistory(),
            TestAppointmentHistory(),
          ],
        ),
      ),
    );
  }
}

// Widget for Doctor Appointment History
class DocAppointmentHistory extends StatelessWidget {
  const DocAppointmentHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<DoctorHistory>('dochistory').listenable(),
      builder: (context, Box<DoctorHistory> box, _) {
        if (box.values.isEmpty) {
          return const Center(child: Text("No Doctor Appointment History"));
        } else {
          final doctorHistoryList = box.values.toList();

          return ListView.builder(
            itemCount: doctorHistoryList.length,
            itemBuilder: (context, index) {
              final history = doctorHistoryList[index];
              return ListTile(
                title: Text("Doctor: ${history.doctorName}"),
                subtitle: Text(
                  'Date: ${DateFormat('dd-MM-yyyy').format(history.appointmentDate)}\n'
                  'Hospital: ${history.hospitalName}',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.red),
                  onPressed: () {
                    _showDeleteConfirmationDialog(context, history, box);
                  },
                ),
              );
            },
          );
        }
      },
    );
  }

  void _deleteDoctorHistory(BuildContext context, DoctorHistory history,
      Box<DoctorHistory> box) async {
    try {
      // Use the key directly from box
      final key =
          box.keys.firstWhere((k) => box.get(k) == history, orElse: () => null);

      if (key != null) {
        await box.delete(key);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Deleted ${history.doctorName}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Record not found')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting data: $e')),
      );
    }
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, DoctorHistory history, Box<DoctorHistory> box) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete ${history.doctorName}?'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _deleteDoctorHistory(context, history, box);
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

// Widget for Test Appointment History
class TestAppointmentHistory extends StatelessWidget {
  const TestAppointmentHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<TestHistory>('testhistory').listenable(),
      builder: (context, Box<TestHistory> box, _) {
        if (box.values.isEmpty) {
          return const Center(child: Text("No Test Appointment History"));
        } else {
          final testHistoryList = box.values.toList();

          return ListView.builder(
            itemCount: testHistoryList.length,
            itemBuilder: (context, index) {
              final history = testHistoryList[index];
              return ListTile(
                title: Text("Test: ${history.testName}"),
                subtitle: Text(
                  'Date: ${DateFormat('dd-MM-yyyy').format(history.testDate)}\n'
                  'Results: ${history.results}',
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.clear, color: Colors.red),
                  onPressed: () {
                    _showDeleteConfirmationDialog(context, history, box);
                  },
                ),
              );
            },
          );
        }
      },
    );
  }

  void _deleteTestHistory(
      BuildContext context, TestHistory history, Box<TestHistory> box) async {
    try {
      // Use the key directly from box
      final key =
          box.keys.firstWhere((k) => box.get(k) == history, orElse: () => null);

      if (key != null) {
        await box.delete(key);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Deleted ${history.testName}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Record not found')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting data: $e')),
      );
    }
  }

  void _showDeleteConfirmationDialog(
      BuildContext context, TestHistory history, Box<TestHistory> box) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete ${history.testName}?'),
        content: const Text('Are you sure you want to delete this item?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _deleteTestHistory(context, history, box);
              Navigator.of(context).pop(); // Close the dialog
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
