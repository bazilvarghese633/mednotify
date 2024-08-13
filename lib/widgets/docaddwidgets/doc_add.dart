import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicine_try1/ui_colors/green.dart';

class CustomScaffolddocadd extends StatelessWidget {
  final String appBarTitle;
  final List<Widget> children;
  final Key formKey;
  final double height;

  const CustomScaffolddocadd({
    Key? key,
    required this.appBarTitle,
    required this.children,
    required this.formKey,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 227, 226, 226),
        title: Text(
          appBarTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: height,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomDateFormFielddoc extends StatelessWidget {
  final DateTime selectDate;

  final Function() onTap;

  const CustomDateFormFielddoc({
    Key? key,
    required this.selectDate,
    required this.onTap,
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
      style: const TextStyle(color: Colors.black, fontSize: 16.0),
      onTap: onTap,
      controller: TextEditingController(
          text: DateFormat('dd-MM-yyyy').format(selectDate)),
    );
  }
}

class CustomDateFormFielddocTime extends StatelessWidget {
  final TimeOfDay selectTime;

  final Function() onTap;

  const CustomDateFormFielddocTime({
    Key? key,
    required this.selectTime,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      decoration: InputDecoration(
        labelText: '',
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2,
            color: greencolor,
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2,
            color: greencolor,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      style: const TextStyle(color: Colors.black, fontSize: 16.0),
      onTap: onTap,
      controller: TextEditingController(text: selectTime.format(context)),
    );
  }
}
