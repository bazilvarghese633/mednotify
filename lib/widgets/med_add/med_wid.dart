import 'package:flutter/material.dart';
import 'package:medicine_try1/widgets/custom_dropdown.dart';

class CustomSilver extends StatelessWidget {
  final List<Map<String, dynamic>> medications;
  final Function(int) deleteMedication;
  final Widget dropdownchild1;
  final Widget dropdownchild2;

  const CustomSilver({
    Key? key,
    required this.medications,
    required this.deleteMedication,
    required this.dropdownchild1,
    required this.dropdownchild2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return ListTile(
                title: sheduleTitleRow(),
                subtitle: Row(
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: dropdownchild1),
                    Padding(
                        padding: const EdgeInsets.only(left: 13),
                        child: dropdownchild2),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.remove_circle_outline),
                  onPressed: () => deleteMedication(index),
                ),
              );
            },
            childCount: medications.length,
          ),
        ),
      ],
    );
  }
}
