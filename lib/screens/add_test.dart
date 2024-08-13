import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:medicine_try1/model/test_history.dart';
import 'package:medicine_try1/model/testappointment.dart';
import 'package:medicine_try1/ui_colors/green.dart';
import 'package:medicine_try1/widgets/title_position.dart';

class TestAppointmentAdd extends StatefulWidget {
  final void Function(TestAppointment testAppointment) onSave;

  const TestAppointmentAdd({super.key, required this.onSave});

  @override
  State<TestAppointmentAdd> createState() => _TestAppointmentAddState();
}

class _TestAppointmentAddState extends State<TestAppointmentAdd> {
  final _formKey = GlobalKey<FormState>();
  final _testNameController = TextEditingController();
  final _laboratoryNameController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  List<String> _selectedImages = [];

  @override
  void dispose() {
    _testNameController.dispose();
    _laboratoryNameController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(), // Restrict to today and future dates
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _pickTime() async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  Future<void> _pickImages() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose an option'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: Text('Camera'),
                  onTap: () async {
                    Navigator.pop(context);
                    final pickedFile = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    if (pickedFile != null) {
                      setState(() {
                        _selectedImages.add(pickedFile.path);
                      });
                    }
                  },
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: Text('Gallery'),
                  onTap: () async {
                    Navigator.pop(context);
                    final pickedFiles = await ImagePicker().pickMultiImage();
                    if (pickedFiles != null) {
                      setState(() {
                        _selectedImages.addAll(
                            pickedFiles.map((file) => file.path).toList());
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      final newAppointment = TestAppointment(
        testName: _testNameController.text,
        laboratoryName: _laboratoryNameController.text,
        date: _selectedDate,
        time: _selectedTime,
        images: _selectedImages,
      );

      final id = DateTime.now()
          .millisecondsSinceEpoch
          .toString(); // Generate a unique ID

      final testHistoryEntry = TestHistory(
        id: id, // Include the unique ID
        testName: _testNameController.text,
        testDate: _selectedDate,
        results: _laboratoryNameController.text,
      );

      final appointmentBox = Hive.box<TestAppointment>('testAppointmentsBox');
      final historyBox = Hive.box<TestHistory>('testhistory');

      await appointmentBox.add(newAppointment);
      await historyBox.add(testHistoryEntry);

      Navigator.pop(context); // Navigate back after saving
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 227, 226, 226),
        title: Center(
          child: const Text(
            'Add Test Appointment      ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomStack(
                  title: "Test Name",
                  child: MedicineTextFieldForm(
                    controller: _testNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the test name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 12),
                CustomStack(
                  title: 'Laboratory Name',
                  child: MedicineTextFieldForm(
                    controller: _laboratoryNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the laboratory name';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Text('Select Date: '),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: _pickDate,
                      child: Text(
                        DateFormat('yyyy-MM-dd').format(_selectedDate),
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text('Select Time: '),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: _pickTime,
                      child: Text(
                        _selectedTime.format(context),
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Text('Add Description Images: '),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: _selectedImages.map((imagePath) {
                          return Image.file(
                            File(imagePath),
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          );
                        }).toList(),
                      ),
                    ),
                    TextButton(
                      onPressed: _pickImages,
                      child: const Text(
                        'Pick Images',
                        style: TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: greencolor),
                  onPressed: _saveForm,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      'SAVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
