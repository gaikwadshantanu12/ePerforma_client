import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/default_animation.dart';
import 'package:student_performance_monitoring_app/middleware/teachers/teacher_mw.dart';
import 'package:student_performance_monitoring_app/models/class/class_details.dart';
import 'package:student_performance_monitoring_app/models/student/student_details.dart';

class ClassTeacherViewStudents extends StatefulWidget {
  const ClassTeacherViewStudents({super.key});

  @override
  State<ClassTeacherViewStudents> createState() =>
      _ClassTeacherViewStudentsState();
}

class _ClassTeacherViewStudentsState extends State<ClassTeacherViewStudents> {
  late ClassDetails classDetails;
  List<StudentDetailsModel> _students = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    isLoading = true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    classDetails = ModalRoute.of(context)!.settings.arguments as ClassDetails;
    _fetchData();
  }

  void _fetchData() {
    TeachersMiddleWare.fetchStudentsByYearSectionAndDepartment(
            classDetails.year, classDetails.section, classDetails.department)
        .then((studentsList) {
      setState(() {
        _students = studentsList;
        isLoading = false;
      });
    });
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.spaceCadet,
        automaticallyImplyLeading: true,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: AppColors.spaceCadet),
        title: Text(
          '${classDetails.year} - ${classDetails.section}\'s Students',
          style: GoogleFonts.getFont(
            'Outfit',
            color: AppColors.isabelline,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
        elevation: 2,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _students.isEmpty
              ? DefaultAnimationMessage(
                  animationFile: "assets/lottie_animations/no_data_found.json",
                  animationMessage:
                      "Oopps !!! No students found for ${classDetails.year} - ${classDetails.section} division students.",
                  deviceWidth: deviceWidth,
                  deviceHeight: deviceHeight,
                )
              : GridView.builder(
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
