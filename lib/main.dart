import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medicine_try1/local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:medicine_try1/screens/welcome_screen.dart';
import 'package:medicine_try1/model/medicine_model.dart';
import 'package:medicine_try1/model/appointment_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDir.path);

  Hive.registerAdapter(MedicineAdapter());
  Hive.registerAdapter(AppointmentAdapter());

  await Hive.openBox<Medicine>('medicine-database');
  await Hive.openBox<Appointment>('appointmentBox');

  await LocalNotifications.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Medicine App',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      home: const WelcomeScreen(),
    );
  }
}
