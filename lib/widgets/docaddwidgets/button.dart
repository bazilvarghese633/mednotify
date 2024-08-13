import 'package:flutter/material.dart';
import 'package:medicine_try1/ui_colors/green.dart';

class CustomSaveButtonDocAdd extends StatelessWidget {
  final Function() saveForm;

  const CustomSaveButtonDocAdd({
    Key? key,
    required this.saveForm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: greencolor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onPressed: saveForm,
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
    );
  }
}
