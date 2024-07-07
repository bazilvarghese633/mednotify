import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medicine_try1/ui_colors/green.dart';
import 'package:medicine_try1/utils/colors_util.dart';
import 'package:medicine_try1/utils/date_utils.dart' as date_util;
import 'package:medicine_try1/model/medicine_model.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late double width;
  late double height;
  late ScrollController scrollController;
  late List<DateTime> currentMonthList;
  late DateTime currentDateTime;
  late Box<Medicine> medicineBox;
  late List<Medicine> filteredMedicines;

  @override
  void initState() {
    super.initState();
    currentDateTime = DateTime.now();
    currentMonthList = date_util.DateUtils.daysInMonth(currentDateTime);
    currentMonthList.sort((a, b) => a.day.compareTo(b.day));
    currentMonthList = currentMonthList.toSet().toList();
    scrollController = ScrollController();

    // Initialize the medicine box
    medicineBox = Hive.box<Medicine>('medicine-database');
    filterMedicines(currentDateTime); // Pass the current date
  }

  void filterMedicines(DateTime selectedDate) {
    filteredMedicines = medicineBox.values.where((medicine) {
      final DateTime startDate = DateTime.parse(medicine.startdate);
      final DateTime endDate = DateTime.parse(medicine.enddate);
      return (selectedDate.isAfter(startDate) &&
              selectedDate.isBefore(endDate)) ||
          selectedDate.isAtSameMomentAs(startDate) ||
          selectedDate.isAtSameMomentAs(endDate);
    }).toList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToCurrentDay();
    });
  }

  void scrollToCurrentDay() {
    final currentDayIndex =
        currentMonthList.indexWhere((date) => date.day == currentDateTime.day);
    if (currentDayIndex != -1) {
      final double itemWidth = 70.0; // Width of each item in the list
      final double screenWidth = MediaQuery.of(context).size.width;
      final double centerOffset =
          (screenWidth - itemWidth) / 2.0; // Offset to center the current day
      final double scrollOffset =
          currentDayIndex * itemWidth - centerOffset; // Scroll to center
      scrollController.animateTo(
        scrollOffset,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget titleView() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 25, 0, 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                currentDateTime =
                    DateTime(currentDateTime.year, currentDateTime.month - 1);
                currentMonthList =
                    date_util.DateUtils.daysInMonth(currentDateTime);
                currentMonthList.sort((a, b) => a.day.compareTo(b.day));
                currentMonthList = currentMonthList.toSet().toList();
                filterMedicines(currentDateTime);
              });
            },
          ),
          Text(
            date_util.DateUtils.months[currentDateTime.month - 1] +
                ' ' +
                currentDateTime.year.toString(),
            style: const TextStyle(
                color: Color.fromARGB(255, 47, 48, 47),
                fontWeight: FontWeight.bold,
                fontSize: 20),
          ),
          IconButton(
            icon: Icon(Icons.arrow_forward),
            onPressed: () {
              setState(() {
                currentDateTime =
                    DateTime(currentDateTime.year, currentDateTime.month + 1);
                currentMonthList =
                    date_util.DateUtils.daysInMonth(currentDateTime);
                currentMonthList.sort((a, b) => a.day.compareTo(b.day));
                currentMonthList = currentMonthList.toSet().toList();
                filterMedicines(currentDateTime);
              });
            },
          ),
        ],
      ),
    );
  }

  Widget horizontalCapsuleListView() {
    return Container(
      width: width,
      height: 80,
      child: ListView.builder(
        controller: scrollController,
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: currentMonthList.length,
        itemBuilder: (BuildContext context, int index) {
          return capsuleView(index);
        },
      ),
    );
  }

  Widget capsuleView(int index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 0, 5),
      child: GestureDetector(
        onTap: () {
          setState(() {
            currentDateTime = currentMonthList[index];
            filterMedicines(currentDateTime);
          });
        },
        child: Container(
          width: 60,
          height: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: (currentMonthList[index].day != currentDateTime.day)
                  ? [
                      Colors.white.withOpacity(0.5),
                      Colors.white.withOpacity(0.5),
                      Colors.white.withOpacity(0.5)
                    ]
                  : [
                      greencolor,
                      greencolor,
                      greencolor,
                    ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(0.0, 1.0),
              stops: const [0.0, 0.5, 1.0],
              tileMode: TileMode.clamp,
            ),
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                offset: Offset(2, 2),
                blurRadius: 4,
                spreadRadius: 2,
                color: Colors.black12,
              )
            ],
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  currentMonthList[index].day.toString(),
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: (currentMonthList[index].day != currentDateTime.day)
                        ? HexColor("465876")
                        : Colors.white,
                  ),
                ),
                Text(
                  date_util
                      .DateUtils.weekdays[currentMonthList[index].weekday - 1],
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: (currentMonthList[index].day != currentDateTime.day)
                        ? HexColor("465876")
                        : Colors.white,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget topView() {
    return Container(
      height: height * 0.24,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            HexColor("#f3f6f4 ").withOpacity(0.7),
            HexColor("#f3f6f4 ").withOpacity(0.5),
            HexColor("#f3f6f4 ").withOpacity(0.3)
          ],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
          stops: const [0.0, 0.5, 1.0],
          tileMode: TileMode.clamp,
        ),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black12,
            offset: Offset(4, 4),
            spreadRadius: 2,
          )
        ],
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          titleView(),
          horizontalCapsuleListView(),
        ],
      ),
    );
  }

  Widget medicineDetailsView(Medicine medicine) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          width: 2,
          color: greencolor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.timer,
                  color: greencolor,
                  size: 40,
                ),
                Text(
                  '${medicine.notifications} / ${medicine.whenm}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: greencolor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Column(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Container(
                        child: Icon(Icons.check),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      '${medicine.medicineName}',
                      style: TextStyle(
                          fontSize: 20,
                          color: greencolor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Qty. ${medicine.dosage} ${medicine.medicineUnit}',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget bottomView() {
    return Container(
      width: width,
      height: height * 0.72,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: filteredMedicines.map((medicine) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  medicineDetailsView(medicine),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            topView(),
            bottomView(),
          ],
        ),
      ),
    );
  }
}
