import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:hive/hive.dart';
import 'package:medicine_try1/model/medicine_model.dart';
import 'package:medicine_try1/screens/med_add_screen.dart';
import 'package:medicine_try1/screens/hive_db_functions/medicine_db.dart';

const addMed_db = 'medicine-database';

class MedicationsScreen extends StatefulWidget {
  const MedicationsScreen({Key? key}) : super(key: key);

  @override
  _MedicationsScreenState createState() => _MedicationsScreenState();
}

class _MedicationsScreenState extends State<MedicationsScreen> {
  late Future<List<Medicine>> _medicationsFuture;
  final MedicineDb _medicineDb = MedicineDb();

  @override
  void initState() {
    super.initState();
    _refreshMedications();
  }

  void _refreshMedications() {
    setState(() {
      _medicationsFuture = _medicineDb.getMedicine();
    });
  }

  Future<void> _deleteMedication(String medId) async {
    await _medicineDb.deleteMedicine(medId);
    _refreshMedications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 227, 226, 226),
        title: Center(
          child: Text(
            'Medications',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: FutureBuilder(
        future: _medicationsFuture,
        builder: (context, AsyncSnapshot<List<Medicine>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              List<Medicine> medications = snapshot.data ?? [];
              return ListView.builder(
                itemCount: medications.length,
                itemBuilder: (context, index) {
                  Medicine medicine = medications[index];
                  return Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(
                          width: 2,
                          color: Color.fromARGB(255, 27, 248, 27),
                        ),
                      ),
                      child: ListTile(
                        title: Row(
                          children: [
                            Icon(
                              Icons.medication_rounded,
                              color: Color.fromARGB(255, 27, 248, 27),
                            ),
                            Text(
                              medicine.medicineName,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 27, 248, 27),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Frequency: ${medicine.frequency}',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Medicine Unit: ${medicine.medicineUnit}',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'When : ${medicine.whenm}',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Dosage : ${medicine.dosage}',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            if (medicine.frequency == 'X Day a Week')
                              Text(
                                'Selected Day: ${medicine.selectedDay}',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            if (medicine.frequency == 'X Day a Month')
                              Text(
                                'Selected Date: ${medicine.selectedDate}',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            Text(
                              'Start Date: ${medicine.startdate}',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text('End Date : ${medicine.enddate}',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            Text('Time : ${medicine.notifications}',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                            Text('Current Stock: ${medicine.currentstock}',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () async {
                            if (medicine.id != null) {
                              await _deleteMedication(medicine.id!);
                            } else {
                              // Handle the case where medicine.id is null, if necessary
                            }
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromARGB(255, 27, 248, 27),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddMedicine()),
          ).then((_) {
            _refreshMedications();
          });
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
