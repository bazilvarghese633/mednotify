import 'package:flutter/material.dart';
import 'package:medicine_try1/ui_colors/green.dart';

Widget titlePosition({
  required String title,
}) {
  return Positioned(
    top: -5.0,
    left: 10.0,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: greencolor, width: 2)),
      child: Text(
        title,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12.0),
      ),
    ),
  );
}

Widget titlePositionS({
  required String titleS,
}) {
  return Positioned(
    top: -10.0,
    left: 10.0,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: greencolor, width: 2)),
      child: Text(
        titleS,
        style: TextStyle(
            color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12.0),
      ),
    ),
  );
}

class CustomStack extends StatelessWidget {
  final Widget child;
  final String title;

  const CustomStack({
    Key? key,
    required this.child,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
            child: child,
          ),
        ),
        titlePosition(title: title),
      ],
    );
  }
}

Widget MedicineTextFieldForm(
    {required final TextEditingController controller, final validator}) {
  return TextFormField(
    controller: controller,
    validator: validator,
    decoration: InputDecoration(
      hintText: "",
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: greencolor,
        ),
        borderRadius: BorderRadius.circular(18),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          width: 2,
          color: greencolor,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    style: TextStyle(color: Colors.black, fontSize: 16.0),
  );
}

class CustomDateFormField extends StatelessWidget {
  final Function(BuildContext) selectDate;

  final TextEditingController controller;

  const CustomDateFormField({
    Key? key,
    required this.selectDate,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: '',
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: greencolor,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: greencolor,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      controller: controller,
      onTap: () => selectDate(context),
    );
  }
}
