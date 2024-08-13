import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicine_try1/ui_colors/green.dart';

class CustomDropdown extends StatelessWidget {
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  final String hintText;

  const CustomDropdown({
    Key? key,
    this.value,
    required this.items,
    required this.onChanged,
    this.hintText = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        hintText: hintText,
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
      onChanged: onChanged,
      items: items.map<DropdownMenuItem<String>>((String unit) {
        return DropdownMenuItem<String>(
          value: unit,
          child: Text(unit),
        );
      }).toList(),
      iconEnabledColor: greencolor,
      iconSize: 30,
    );
  }
}

class CurrentStockDropdown extends StatefulWidget {
  final int? value;
  final List<int> items;
  final ValueChanged<int?> onChanged;
  final String selectedUnit;
  final Color borderColor;

  const CurrentStockDropdown({
    Key? key,
    this.value,
    required this.items,
    required this.onChanged,
    required this.selectedUnit,
    required this.borderColor,
  }) : super(key: key);

  @override
  _CurrentStockDropdownState createState() => _CurrentStockDropdownState();
}

class _CurrentStockDropdownState extends State<CurrentStockDropdown> {
  late TextEditingController _controller;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: widget.value?.toString() ?? '',
    );
  }

  @override
  void didUpdateWidget(covariant CurrentStockDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isEditing) {
      _controller.text = widget.value?.toString() ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: widget.borderColor,
              width: 3,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 50, // Set a fixed width for the text field
                child: Focus(
                  onFocusChange: (hasFocus) {
                    if (hasFocus) {
                      _controller.clear(); // Clear the field when focused
                      _isEditing = true;
                    } else {
                      _isEditing = false;
                    }
                  },
                  child: TextField(
                    controller: _controller,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (String newValue) {
                      int? intValue = int.tryParse(newValue);
                      widget.onChanged(intValue);
                    },
                    onSubmitted: (_) {
                      FocusScope.of(context)
                          .unfocus(); // Hide the keyboard after submitting
                    },
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.arrow_drop_down),
                onPressed: () {
                  _showDropdown(context);
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(widget.selectedUnit),
        ),
      ],
    );
  }

  void _showDropdown(BuildContext context) {
    final RenderBox renderBox = context.findRenderObject() as RenderBox;
    final overlay = Overlay.of(context).context.findRenderObject();
    final position = renderBox.localToGlobal(Offset.zero);

    showMenu<int>(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy + renderBox.size.height,
        overlay?.semanticBounds.width ?? 0,
        0,
      ),
      items: widget.items
          .map<PopupMenuItem<int>>(
            (int value) => PopupMenuItem<int>(
              value: value,
              child: Text(value.toString()),
            ),
          )
          .toList(),
    ).then((int? newValue) {
      if (newValue != null) {
        widget.onChanged(newValue);
        setState(() {
          _controller.text = newValue.toString();
        });
      }
    });
  }
}

Widget sheduleTitleRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "    When",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        "Dosage",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}

Widget notificationTitleRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        "Time",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    ],
  );
}
