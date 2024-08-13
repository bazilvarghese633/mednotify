import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';
import 'package:medicine_try1/model/testappointment.dart';

class ViewTestAppointmentScreen extends StatelessWidget {
  final TestAppointment testAppointment;
  final int appointmentIndex;

  const ViewTestAppointmentScreen({
    super.key,
    required this.testAppointment,
    required this.appointmentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 227, 226, 226),
        title: Center(
          child: Text(
            'View Test Appointment',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTestAppointmentScreen(
                    testAppointment: testAppointment,
                    appointmentIndex: appointmentIndex,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              final confirmDelete = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Confirm Delete'),
                  content:
                      Text('Are you sure you want to delete this appointment?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text('Delete'),
                    ),
                  ],
                ),
              );

              if (confirmDelete == true) {
                final box = Hive.box<TestAppointment>('testAppointmentsBox');
                await box.deleteAt(appointmentIndex);
                Navigator.pop(context); // Go back to previous screen
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Test Name: ${testAppointment.testName}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Laboratory Name: ${testAppointment.laboratoryName}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Date: ${DateFormat('yyyy-MM-dd').format(testAppointment.date)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              'Time: ${testAppointment.time.format(context)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              'Images:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: testAppointment.images.length,
                itemBuilder: (context, index) {
                  final imagePath = testAppointment.images[index];
                  return ListTile(
                    leading: Image.file(
                      File(imagePath),
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ImageViewer(imagePath: imagePath),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageViewer extends StatelessWidget {
  final String imagePath;

  const ImageViewer({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Viewer'),
      ),
      body: Center(
        child: Image.file(File(imagePath)),
      ),
    );
  }
}

class EditTestAppointmentScreen extends StatelessWidget {
  final TestAppointment testAppointment;
  final int appointmentIndex;

  const EditTestAppointmentScreen({
    super.key,
    required this.testAppointment,
    required this.appointmentIndex,
  });

  @override
  Widget build(BuildContext context) {
    // Your implementation for editing the test appointment
    // This will typically include a form to edit the appointment details

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Test Appointment'),
      ),
      body: Center(
        child: Text('Edit Test Appointment Screen'),
      ),
    );
  }
}
