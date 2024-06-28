import 'package:flutter/material.dart';
// ignore: unnecessary_import
import 'package:flutter/widgets.dart';
import 'package:medicine_try1/model/medicine_model.dart';
import 'package:medicine_try1/screens/hive_db_functions/medicine_db.dart';
import 'package:medicine_try1/widgets/title_position.dart';
import 'package:intl/intl.dart';

// ignore: unused_import
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({Key? key}) : super(key: key);

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  final _medicationNameController = TextEditingController();

  // ignore: unused_field
  String _medicationName = '';
  String _selectedUnit = 'Tabs';
  String _frequency = 'Everyday';
  bool _showWeekDaySelection = false;
  DateTime? _selectedDate;
  DateTime? _startedDate;
  DateTime? _endedDate;
  List<String> _selectedDays = [];
  List<Map<String, dynamic>> _medications = [];
  List<TimeOfDay?> _notifications = [];
  TimeOfDay? _selectedTime;

  List<String> _units = ['Tabs', 'TBspoon', 'ml', 'Drops'];
  List<String> _frequencies = ['Everyday', 'X Day a Week', 'X Day a Month'];
  List<String> _weekDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  MedicineDb med = MedicineDb();

  List<String> _dropdownWhen = [
    'After Breakfast',
    'Before Breakfast',
    'Before Lunch',
    'After Lunch',
    'Before Dinner',
    'After Dinner'
  ];

  List<int> _dosageList = List<int>.generate(100, (i) => i + 1);

  int _selectedStock = 1;
  List<int> _currentStock = List.generate(100, (index) => index + 1);

  int _selectedDe = 1;
  List<int> _deStock = List.generate(100, (index) => index + 1);

  @override
  void initState() {
    super.initState();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _startDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _startedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != _startDate) {
      setState(() {
        _startedDate = picked;
      });
    }
  }

  Future<void> _endDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _endedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != _endDate) {
      setState(() {
        _endedDate = picked;
      });
    }
  }

  void _showTimePicker(int index) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _notifications[index] ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _notifications[index] = picked;
      });
    }
  }

  String _formatTime(TimeOfDay time) {
    final formatter = DateFormat.jm('en_US');
    return formatter.format(DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      time.hour,
      time.minute,
    ));
  }

  void _addMedication() {
    setState(() {
      _medications.add({
        'name': _medicationNameController.text,
        'unit': _selectedUnit,
        'frequency': _frequency,
        'days': _selectedDays,
        'date': _selectedDate,
        'when': _dropdownWhen.first,
        'dosage': 1,
        'currentStock': 1,
        'destock': 1,
      });
    });
  }

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  void _addNotifications() {
    setState(() {
      _notifications.add(_selectedTime);
      _selectedTime = null;
    });
  }

  void _deleteNotifications(int index) {
    setState(() {
      _notifications.removeAt(index);
    });
  }

  void _deleteMedication(int index) {
    setState(() {
      _medications.removeAt(index);
    });
  }

  void _updateMedicationWhen(int index, String newValue) {
    setState(() {
      _medications[index]['when'] = newValue;
    });
  }

  void _updateMedicationDosage(int index, int newValue) {
    setState(() {
      _medications[index]['dosage'] = newValue;
    });
  }

  Widget _buildSelectedItem(String item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: item.split(' ').map((word) => Text(word)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 227, 226, 226),
        title: Text(
          "         Add Medication",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
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
                      child: TextFormField(
                        controller: _medicationNameController,
                        decoration: InputDecoration(
                          hintText: "",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 27, 248, 27),
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 27, 248, 27),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        style: TextStyle(color: Colors.black, fontSize: 16.0),
                      ),
                    ),
                  ),
                  titlePosition(title: "Medicine Name"),
                ],
              ),
              Stack(
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
                      child: DropdownButtonFormField<String>(
                        value: _selectedUnit,
                        decoration: InputDecoration(
                          hintText: "",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 27, 248, 27),
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 27, 248, 27),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedUnit = newValue!;
                          });
                        },
                        items:
                            _units.map<DropdownMenuItem<String>>((String unit) {
                          return DropdownMenuItem<String>(
                            value: unit,
                            child: Text(unit),
                          );
                        }).toList(),
                        iconEnabledColor:
                            const Color.fromARGB(255, 35, 225, 42),
                        iconSize: 30,
                      ),
                    ),
                  ),
                  titlePosition(title: "Medicine Unit"),
                ],
              ),
              Stack(
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
                      child: DropdownButtonFormField<String>(
                        value: _frequency,
                        decoration: InputDecoration(
                          hintText: "",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 27, 248, 27),
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color:
                                  Color.fromARGB(255, 27, 248, 27), // Red color
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _frequency = newValue!;
                            _showWeekDaySelection =
                                _frequency == 'X Day a Week';
                            _selectedDays = [];
                          });
                        },
                        items: _frequencies
                            .map<DropdownMenuItem<String>>((String freq) {
                          return DropdownMenuItem<String>(
                            value: freq,
                            child: Text(freq),
                          );
                        }).toList(),
                        iconEnabledColor:
                            const Color.fromARGB(255, 35, 225, 42),
                        iconSize: 30,
                      ),
                    ),
                  ),
                  titlePosition(title: "Frequency"),
                ],
              ),
              if (_showWeekDaySelection)
                Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        hintText: "Select a Day",
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 27, 248, 27),
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            width: 2,
                            color: Color.fromARGB(255, 27, 248, 27),
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onChanged: (String? newValue) {
                        if (newValue != null &&
                            !_selectedDays.contains(newValue)) {
                          setState(() {
                            _selectedDays.add(newValue);
                          });
                        }
                      },
                      items:
                          _weekDays.map<DropdownMenuItem<String>>((String day) {
                        return DropdownMenuItem<String>(
                          value: day,
                          child: Text(day),
                        );
                      }).toList(),
                    ),
                  ),
                )
              else if (_frequency == 'X Day a Month')
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
                        child: TextFormField(
                          readOnly: true,
                          decoration: InputDecoration(
                            labelText: '',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color.fromARGB(255, 27, 248, 27),
                              ),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 2,
                                color: Color.fromARGB(255, 27, 248, 27),
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          controller: TextEditingController(
                            text: _selectedDate != null
                                ? DateFormat('dd-MM-yyyy')
                                    .format(_selectedDate!)
                                : '',
                          ),
                          onTap: () => _selectDate(context),
                        ),
                      ),
                    ),
                    titlePosition(title: "Select the Date"),
                  ],
                ),
              Stack(
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
                          color: Color.fromARGB(255, 27, 248, 27),
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
                                padding: const EdgeInsets.only(
                                    top: 14, bottom: 14, right: 1),
                                child: Scrollbar(
                                  thumbVisibility: true,
                                  thickness: 6,
                                  radius: Radius.circular(8),
                                  child: CustomScrollView(
                                    slivers: [
                                      SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                          (BuildContext context, int index) {
                                            return ListTile(
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "    When",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Dosage",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              subtitle: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 20),
                                                    child:
                                                        DropdownButton<String>(
                                                      value: _medications[index]
                                                          ['when'],
                                                      onChanged:
                                                          (String? newValue) {
                                                        setState(() {
                                                          _updateMedicationWhen(
                                                              index, newValue!);
                                                        });
                                                      },
                                                      items: _dropdownWhen.map<
                                                              DropdownMenuItem<
                                                                  String>>(
                                                          (String value) {
                                                        return DropdownMenuItem<
                                                            String>(
                                                          value: value,
                                                          child:
                                                              _buildSelectedItem(
                                                                  value),
                                                        );
                                                      }).toList(),
                                                      iconEnabledColor:
                                                          const Color.fromARGB(
                                                              255, 35, 225, 42),
                                                      iconSize: 30,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 13),
                                                    child: DropdownButton<int>(
                                                      menuMaxHeight: 250,
                                                      value: _medications[index]
                                                          ['dosage'],
                                                      onChanged:
                                                          (int? newValue) {
                                                        setState(() {
                                                          _updateMedicationDosage(
                                                              index, newValue!);
                                                        });
                                                      },
                                                      items: _dosageList.map<
                                                              DropdownMenuItem<
                                                                  int>>(
                                                          (int value) {
                                                        return DropdownMenuItem<
                                                            int>(
                                                          value: value,
                                                          child: Text(
                                                              value.toString()),
                                                        );
                                                      }).toList(),
                                                      iconEnabledColor:
                                                          const Color.fromARGB(
                                                              255, 35, 225, 42),
                                                      iconSize: 30,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              trailing: IconButton(
                                                icon: Icon(Icons
                                                    .remove_circle_outline),
                                                onPressed: () =>
                                                    _deleteMedication(index),
                                              ),
                                            );
                                          },
                                          childCount: _medications.length,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _addMedication,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 63, 222, 68),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
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
                  titlePositionS(titleS: "Schedule"),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
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
                          color: Color.fromARGB(255, 27, 248, 27),
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
                                padding: const EdgeInsets.only(
                                    top: 14, bottom: 14, right: 1),
                                child: Scrollbar(
                                  thumbVisibility: true,
                                  thickness: 6,
                                  radius: Radius.circular(8),
                                  child: CustomScrollView(
                                    slivers: [
                                      SliverList(
                                        delegate: SliverChildBuilderDelegate(
                                          (BuildContext context, int index) {
                                            return ListTile(
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Time",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              subtitle: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        _showTimePicker(index),
                                                    child: Text(
                                                      _notifications[index]
                                                              ?.format(
                                                                  context) ??
                                                          'Select Time',
                                                      style: TextStyle(
                                                        color: _notifications[
                                                                    index] !=
                                                                null
                                                            ? Color.fromARGB(
                                                                255,
                                                                35,
                                                                239,
                                                                39)
                                                            : Colors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              trailing: IconButton(
                                                icon: Icon(Icons
                                                    .remove_circle_outline),
                                                onPressed: () =>
                                                    _deleteNotifications(index),
                                              ),
                                            );
                                          },
                                          childCount: _notifications.length,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: _addNotifications,
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 63, 222, 68),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
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
                  titlePositionS(titleS: "Notification Time"),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Stack(
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
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: '',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 27, 248, 27),
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 27, 248, 27),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        controller: TextEditingController(
                          text: _startedDate != null
                              ? DateFormat('dd-MM-yyyy').format(_startedDate!)
                              : '',
                        ),
                        onTap: () => _startDate(context),
                      ),
                    ),
                  ),
                  titlePosition(title: "Start Date"),
                ],
              ),
              Stack(
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
                      child: TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: '',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 27, 248, 27),
                            ),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 2,
                              color: Color.fromARGB(255, 27, 248, 27),
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        controller: TextEditingController(
                          text: _endedDate != null
                              ? DateFormat('dd-MM-yyyy').format(_endedDate!)
                              : '',
                        ),
                        onTap: () => _endDate(context),
                      ),
                    ),
                  ),
                  titlePosition(title: "End Date"),
                ],
              ),
              Stack(
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
                          color: Color.fromARGB(255, 27, 248, 27),
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 30, bottom: 30),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 40),
                                      child: Text("Currently in stock"),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                              color: const Color.fromARGB(255,
                                                  37, 231, 44), // Border color
                                              width: 3, // Border width
                                            ),
                                          ),
                                          child: DropdownButton<int>(
                                            underline: SizedBox(),
                                            menuMaxHeight: 250,
                                            value: _selectedStock,
                                            onChanged: (int? newValue) {
                                              setState(() {
                                                _selectedStock = newValue!;
                                              });
                                            },
                                            items: _currentStock
                                                .map<DropdownMenuItem<int>>(
                                                    (int value) {
                                              return DropdownMenuItem<int>(
                                                value: value,
                                                child: Text(value.toString()),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(_selectedUnit),
                                        ),
                                      ],
                                    )
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
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: Column(
                                  children: [
                                    Text("Remind me when stock decreses to "),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 6),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            border: Border.all(
                                              color: Color.fromARGB(
                                                  255, 248, 23, 23),
                                              width: 3, // Border width
                                            ),
                                          ),
                                          child: DropdownButton<int>(
                                            underline: SizedBox(),
                                            menuMaxHeight: 250,
                                            value: _selectedDe,
                                            onChanged: (int? newValue) {
                                              setState(() {
                                                _selectedDe = newValue!;
                                              });
                                            },
                                            items: _deStock
                                                .map<DropdownMenuItem<int>>(
                                                    (int value) {
                                              return DropdownMenuItem<int>(
                                                value: value,
                                                child: Text(value.toString()),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(_selectedUnit),
                                        )
                                      ],
                                    )
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
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 20),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      List<Future<void>> saveFutures = [];

                      for (int i = 0; i < _medications.length; i++) {
                        if (_medications[i]['when'] != null &&
                            _medications[i]['dosage'] != null) {
                          var values = Medicine(
                            id: DateTime.now()
                                .microsecondsSinceEpoch
                                .toString(),
                            medicineName: _medicationNameController.text,
                            medicineUnit: _selectedUnit,
                            frequency: _frequency,
                            selectedDay: _selectedDays.toString(),
                            selectedDate: _selectedDate != null
                                ? dateFormat.format(_selectedDate!)
                                : '',
                            whenm: _medications[i]['when'].toString(),
                            dosage: _medications[i]['dosage'].toString(),
                            notifications: _notifications
                                .map((time) => _formatTime(time!))
                                .join(', '),
                            startdate: _startedDate != null
                                ? dateFormat.format(_startedDate!)
                                : '',
                            enddate: _endedDate != null
                                ? dateFormat.format(_endedDate!)
                                : '',
                            currentstock: _selectedStock.toString(),
                            destock: _selectedDe.toString(),
                          );

                          saveFutures.add(med.addMedicienDetails(values));
                        }
                      }

                      await Future.wait(saveFutures);

                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 43, 241, 46),
                      padding:
                          EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'SAVE',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
