import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/default_animation.dart';
import 'package:student_performance_monitoring_app/middleware/hod/hod_mw.dart';
import 'package:student_performance_monitoring_app/models/student/student_details.dart';

class StudentsGrid extends StatefulWidget {
  final String year;
  final String department;
  final String section;
  const StudentsGrid(
      {super.key,
      required this.year,
      required this.department,
      required this.section});

  @override
  State<StudentsGrid> createState() => _StudentsGridState();
}

class _StudentsGridState extends State<StudentsGrid> {
  List<StudentDetailsModel> _students = [];
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    HodMiddleWare.fetchDepartmentYearAndSectionWiseStudentsList(
            widget.department, widget.year, widget.section)
        .then((studentsList) {
      setState(() {
        _students = studentsList;
      });
    });
  }

  void _onRefresh() async {
    _fetchData();
    _refreshController.refreshCompleted();
  }

  void _showStudentDialog(BuildContext context, StudentDetailsModel student,
      double height, double width) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Student Information",
          textAlign: TextAlign.center,
          style: GoogleFonts.getFont(
            'Outfit',
            color: AppColors.spaceCadet,
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 80,
              child: Container(
                width: width * 0.6,
                height: height * 0.3,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Image.network(
                  'https://picsum.photos/seed/974/600',
                  fit: BoxFit.cover,
                ),
              ), // Placeholder icon
            ),
            SizedBox(height: height * 0.05),
            Text(
              student.studentName,
              style: GoogleFonts.getFont(
                'Outfit',
                color: AppColors.spaceCadet,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "(${student.studentCurrentYear} - ${student.studentDepartment})",
              style: GoogleFonts.getFont(
                'Outfit',
                color: AppColors.spaceCadet,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: height * 0.03),
            Text(student.studentPersonalEmail),
            SizedBox(height: height * 0.01),
            Text(student.studentCollegeID),
            SizedBox(height: height * 0.01),
            Text(student.studentMobile),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Access Document'),
            onPressed: () => Navigator.pushNamed(
              context,
              '/hod/access_student_documents',
              arguments: student,
            ),
          ),
          TextButton(
            child: const Text('Close'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return _students.isEmpty
        ? DefaultAnimationMessage(
            animationFile: "assets/lottie_animations/no_data_found.json",
            animationMessage:
                "Oopps !!! No data found for ${widget.year} - ${widget.section} division.",
            deviceWidth: deviceWidth,
            deviceHeight: deviceHeight,
          )
        : Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: _students.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => _showStudentDialog(
                      context, _students[index], deviceHeight, deviceWidth),
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: AppColors.isabelline,
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: deviceWidth * 0.2,
                          height: deviceHeight * 0.1,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            'https://picsum.photos/seed/974/600',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          _students[index].studentName,
                          style: GoogleFonts.getFont(
                            "Readex Pro",
                            textStyle: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}
