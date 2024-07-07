import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicine_try1/model/appointment_model.dart';
import 'package:medicine_try1/ui_colors/green.dart';
import 'package:medicine_try1/widgets/title_position.dart';

class AppointmentAdd extends StatefulWidget {
  final Function(Appointment) onSave;

  AppointmentAdd({required this.onSave});

  @override
  _AppointmentAddState createState() => _AppointmentAddState();
}

class _AppointmentAddState extends State<AppointmentAdd> {
  final _formKey = GlobalKey<FormState>();
  final _doctorNameController = TextEditingController();
  final _hospitalNameController = TextEditingController();
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      final newAppointment = Appointment(
        doctorName: _doctorNameController.text,
        hospitalName: _hospitalNameController.text,
        appointmentDate: _selectedDate,
        appointmentTime: '${_selectedTime.hour}:${_selectedTime.minute}',
      );
      widget.onSave(newAppointment);
      Navigator.of(context).pop(newAppointment);
    }
  }

  void _presentDatePicker() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _presentTimePicker() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 227, 226, 226),
        title: const Text(
          "       Add Appointment",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: screenHeight,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                          child: TextFormField(
                            controller: _doctorNameController,
                            decoration: InputDecoration(
                              hintText: "",
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: greencolor,
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: greencolor,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16.0),
                          ),
                        ),
                      ),
                      titlePosition(title: "Doctor Name")
                    ],
                  ),
                  const SizedBox(height: 12),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                          child: TextFormField(
                            controller: _hospitalNameController,
                            decoration: InputDecoration(
                              hintText: "",
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: greencolor,
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: greencolor,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16.0),
                          ),
                        ),
                      ),
                      titlePosition(title: "Hospital Name")
                    ],
                  ),
                  const SizedBox(height: 12),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                          child: TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: '',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: greencolor,
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: greencolor,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16.0),
                            onTap: _presentDatePicker,
                            controller: TextEditingController(
                                text: DateFormat('dd-MM-yyyy')
                                    .format(_selectedDate)),
                          ),
                        ),
                      ),
                      titlePosition(title: "Select Date ")
                    ],
                  ),
                  const SizedBox(height: 12),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                          child: TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: '',
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: greencolor,
                                ),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  width: 2,
                                  color: greencolor,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16.0),
                            onTap: _presentTimePicker,
                            controller: TextEditingController(
                                text: _selectedTime.format(context)),
                          ),
                        ),
                      ),
                      titlePosition(title: "Select Time")
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: greencolor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: _saveForm,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Text(
                        'Add Appointment',
                        style: TextStyle(
                          color: Colors.black,
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
      ),
    );
  }
}
