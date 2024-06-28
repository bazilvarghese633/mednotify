import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medicine_try1/screens/start_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 219, 243, 202),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Stack(
              children: [
                Image.asset(
                    "assert/images/Screenshot_2024-04-18_at_11.00.57_AM-removebg-preview.png"),
                const Positioned(
                  bottom: 10.0,
                  left: 0.0,
                  right: 0.0,
                  child: Center(
                    child: Text(
                      "Never Forget Your Meds Again",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(key: UniqueKey())),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 17, 235, 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 60.0, vertical: 20.0),
                ),
                child: const Text(
                  "GET STARTED",
                  style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 150,
            )
          ],
        ),
      ),
    );
  }
}
