import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:intl/intl.dart';
import 'package:medicine_try1/model/appointment_model.dart';
import 'package:medicine_try1/screens/docappointment_add_screen.dart';

class DoctorAppointmentScreen extends StatefulWidget {
  @override
  _DoctorAppointmentScreenState createState() =>
      _DoctorAppointmentScreenState();
}

class _DoctorAppointmentScreenState extends State<DoctorAppointmentScreen> {
  late Box<Appointment> _appointmentBox;

  @override
  void initState() {
    super.initState();
    _appointmentBox = Hive.box<Appointment>('appointmentBox');
  }

  void _addAppointment(Appointment appointment) {
    setState(() {
      _appointmentBox.add(appointment);
    });
  }

  void _deleteAppointment(int index) {
    setState(() {
      _appointmentBox.deleteAt(index);
    });
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); // 'jm' will format time as AM/PM
    return format.format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 227, 226, 226),
        title: Center(
          child: Text(
            'Next Appointment',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: _appointmentBox.listenable(),
        builder: (context, Box<Appointment> box, _) {
          if (box.values.isEmpty) {
            return Center(child: Text("No Appointments"));
          } else {
            return ListView.builder(
              itemCount: box.values.length,
              itemBuilder: (context, index) {
                final appointment = box.getAt(index)!;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        width: 2,
                        color: Color.fromARGB(255, 27, 248, 27),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 5, top: 5, bottom: 5, right: 5),
                      child: ListTile(
                        title: Text(
                          "Doctor: ${appointment.doctorName}",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "Hospital: ${appointment.hospitalName}\n"
                          "Date: ${DateFormat('dd-MM-yyyy').format(appointment.appointmentDate)}\n"
                          "Time: ${formatTimeOfDay(appointment.appointmentTimeOfDay)}",
                        ),
                        leading: Icon(
                          IcoFontIcons.doctor,
                          color: Color.fromARGB(255, 55, 234, 171),
                          size: 40,
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete,
                              color: Colors.red), // Red delete icon
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Confirm"),
                                  content: Text(
                                    "Are you sure you want to delete this appointment?",
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text("CANCEL"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text("DELETE"),
                                      onPressed: () {
                                        _deleteAppointment(index);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromARGB(255, 27, 248, 27),
        onPressed: () async {
          final newAppointment = await Navigator.push<Appointment>(
            context,
            MaterialPageRoute(
              builder: (context) => AppointmentAdd(onSave: _addAppointment),
            ),
          );

          if (newAppointment != null) {
            _addAppointment(newAppointment);
          }
        },
        label: Row(
          children: [
            Icon(Icons.add),
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
