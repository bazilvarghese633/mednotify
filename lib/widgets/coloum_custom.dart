import 'package:flutter/material.dart';
import 'package:medicine_try1/ui_colors/green.dart';
import 'package:medicine_try1/widgets/title_position.dart';

class CustomColoumStack extends StatelessWidget {
  final Widget child;
  final String titleS;
  final VoidCallback onPressed;

  const CustomColoumStack({
    Key? key,
    required this.child,
    required this.titleS,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
            height: 380,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                width: 2,
                color: greencolor,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 25, left: 20, right: 20, bottom: 20),
              child: Column(
                children: [
                  Container(
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        width: 2,
                        color: Color.fromARGB(255, 1, 2, 1),
                      ),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(top: 14, bottom: 14, right: 1),
                      child: Scrollbar(
                          thumbVisibility: true,
                          thickness: 6,
                          radius: Radius.circular(8),
                          child: child),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: onPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: greencolor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.add,
                          size: 24,
                          color: Colors.black,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Add',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        titlePositionS(titleS: titleS),
      ],
    );
  }
}

class CustomStockColum extends StatelessWidget {
  final Widget row1;
  final Widget row2;
  final String titleS;

  const CustomStockColum({
    Key? key,
    required this.row1,
    required this.row2,
    required this.titleS,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
            height: 280,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                width: 2,
                color: greencolor,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30, bottom: 30),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: Text("Currently in stock"),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          row1,
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                  thickness: 1,
                  color: Colors.black,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Column(
                        children: [
                          Text("Remind me when stock decreses to "),
                          SizedBox(
                            height: 5,
                          ),
                          row2
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        titlePositionS(titleS: "Medicine Stock")
      ],
    );
  }
}
