import 'package:flutter/material.dart';

class MedicineStockScreen extends StatelessWidget {
  const MedicineStockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 227, 226, 226),
        title: Center(
          child: Text(
            "Medicine Stock          ",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Center(
        child: Text("Medicine Stock Screen"),
      ),
    );
  }
}
