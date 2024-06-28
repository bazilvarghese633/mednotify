import 'package:flutter/material.dart';
import 'package:medicine_try1/local_notifications.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 227, 226, 226),
        title: Center(
          child: Text(
            "Settings           ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Center(
        child: ElevatedButton.icon(
            onPressed: () {
              LocalNotifications.showSimpleNotification(
                  title: "hello there",
                  body: "you have done it",
                  payload: "you are brilliant");
            },
            icon: Icon(Icons.notification_add),
            label: Text("simple notification")),
      ),
    );
  }
}
