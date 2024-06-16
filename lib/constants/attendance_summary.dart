import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';

// ignore: must_be_immutable
class AttendanceOverview extends StatefulWidget {
  Map<String, dynamic> lectureAttendanceData;
  AttendanceOverview({
    Key? key,
    required this.lectureAttendanceData,
  }) : super(key: key);

  @override
  State<AttendanceOverview> createState() => _AttendanceOverviewState();
}

class _AttendanceOverviewState extends State<AttendanceOverview> {
  Map<String, dynamic> attendanceData = {};
  String selectedDate = '';
  List<String> dates = [];

  @override
  void initState() {
    super.initState();
    // Parsing the JSON string
    attendanceData = widget.lectureAttendanceData;
    dates = attendanceData.keys.toList();
    if (dates.isNotEmpty) {
      selectedDate = dates[0];
    }
  }

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> selectedData = attendanceData[selectedDate] ?? {};

    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
            children: [
              Text(
                "Attendance filteration based on dates selection in dropdown.",
                style: GoogleFonts.getFont(
                  'Readex Pro',
                  color: AppColors.spaceCadet,
                  fontSize: 15,
                ),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: DropdownButton<String>(
                  value: selectedDate,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDate = newValue!;
                    });
                  },
                  items: dates.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              DataTable(
                columnSpacing: MediaQuery.of(context).size.width / 4,
                headingRowColor:
                    MaterialStateProperty.all(AppColors.silverPink),
                dataRowColor:
                    MaterialStateProperty.all(AppColors.heliotropeGray),
                headingTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.spaceCadet,
                ),
                dataTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: AppColors.isabelline,
                ),
                dataRowMaxHeight: 60,
                dataRowMinHeight: 60,
                dividerThickness: 3,
                columns: const [
                  DataColumn(label: Text('Student UID')),
                  DataColumn(label: Text('Total Lectures Till Date')),
                  DataColumn(label: Text('Present Lectures Till Date')),
                  DataColumn(label: Text('Present For Today')),
                ],
                rows: selectedData.entries.map((entry) {
                  return DataRow(
                    cells: [
                      DataCell(Center(
                        child: Text(entry.key),
                      )),
                      DataCell(Center(
                        child: Text(
                            entry.value['totalLecturesTillDate'].toString()),
                      )),
                      DataCell(Center(
                        child: Text(
                            entry.value['presentLecturesTillDate'].toString()),
                      )),
                      DataCell(Center(
                        child: Text(entry.value['presentForToday'].toString()),
                      )),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
