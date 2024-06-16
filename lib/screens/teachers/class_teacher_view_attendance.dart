import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/models/class/class_details.dart';

class ClassTeacherViewAttendance extends StatefulWidget {
  const ClassTeacherViewAttendance({super.key});

  @override
  State<ClassTeacherViewAttendance> createState() =>
      _ClassTeacherViewAttendanceState();
}

class _ClassTeacherViewAttendanceState
    extends State<ClassTeacherViewAttendance> {
  late ClassDetails classDetails;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    classDetails = ModalRoute.of(context)!.settings.arguments as ClassDetails;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.spaceCadet,
        automaticallyImplyLeading: true,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: AppColors.spaceCadet),
        title: Text(
          '${classDetails.year} - ${classDetails.section}\'s Attendance',
          style: GoogleFonts.getFont(
            'Outfit',
            color: AppColors.isabelline,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
        elevation: 2,
      ),
    );
  }
}
