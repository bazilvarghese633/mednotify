import 'package:flutter/material.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:medicine_try1/screens/doctor_appointment.dart';
import 'package:medicine_try1/screens/home_screen_widget.dart';
import 'package:medicine_try1/screens/medications_list_screen.dart';
import 'package:medicine_try1/screens/more_screen.dart';
import 'package:medicine_try1/ui_colors/green.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const MyHomePage(title: 'MedNotify'),
    const MedicationsScreen(),
    DoctorAppointmentScreen(),
    const MoreScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: SingleChildScrollView(
        child: BottomNavigationBar(
          selectedItemColor: greencolor,
          unselectedItemColor: const Color.fromARGB(255, 106, 106, 106),
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                IcoFontIcons.medicine,
              ),
              label: 'Medications',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                IcoFontIcons.doctor,
              ),
              label: 'Doctor Appointment',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more),
              label: 'More',
            ),
          ],
        ),
      ),
    );
  }
}
