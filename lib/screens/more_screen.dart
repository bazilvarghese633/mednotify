import 'package:flutter/material.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:medicine_try1/screens/medicine_stock.dart';
import 'package:medicine_try1/screens/settings_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 227, 226, 226),
        title: Center(
          child: Text(
            'More',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Card(
                    elevation: 20,
                    color: Colors.blue,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TestAppointmentScreen()),
                              );
                            },
                            child: Column(
                              children: [
                                Text(
                                  "Test Appointments",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(
                                  color: Colors.white,
                                  IcoFontIcons.laboratory,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    elevation: 20,
                    color: const Color.fromARGB(255, 243, 33, 37),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 25, top: 15, bottom: 15, right: 25),
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        MedicineStockScreen()),
                              );
                            },
                            child: Column(
                              children: [
                                Text(
                                  "Medicine Stock",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(
                                  color: Colors.white,
                                  Icons.local_pharmacy_rounded,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 20,
                  color: Color.fromARGB(255, 65, 33, 243),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 25, top: 15, bottom: 15, right: 25),
                    child: Column(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SettingsScreen()),
                            );
                          },
                          child: Column(
                            children: [
                              Text(
                                "Settings",
                                style: TextStyle(color: Colors.white),
                              ),
                              Icon(
                                color: Colors.white,
                                Icons.settings,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TestAppointmentScreen extends StatelessWidget {
  const TestAppointmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 227, 226, 226),
        title: Center(
          child: Text(
            'Test Appointments           ',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Center(child: Text("Test Appointments Screen")),
    );
  }
}
