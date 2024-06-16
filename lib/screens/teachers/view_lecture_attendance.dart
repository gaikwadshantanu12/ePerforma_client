import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/attendance_summary.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/middleware/teachers/teacher_mw.dart';
import 'package:student_performance_monitoring_app/models/subject/subject_details.dart';
import 'package:student_performance_monitoring_app/models/teacher/teacher_details.dart';

class ViewLectureAttendance extends StatefulWidget {
  const ViewLectureAttendance({super.key});

  @override
  State<ViewLectureAttendance> createState() => _ViewLectureAttendanceState();
}

class _ViewLectureAttendanceState extends State<ViewLectureAttendance> {
  SubjectDetails? _subject;
  late TeacherDetailsModel _teacher;
  List<SubjectDetails> subjects = [];
  Map<String, dynamic>? _lectureAttendanceData;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _teacher =
        ModalRoute.of(context)?.settings.arguments as TeacherDetailsModel;
    _fetchMySubjects();
  }

  void _fetchMySubjects() {
    TeachersMiddleWare.fetchTeacherSubjects(_teacher.teacherCollegeID)
        .then((subjectList) {
      setState(() {
        subjects = subjectList;
      });
    });
  }

  void _fetchParticularSubjectAttendance(SubjectDetails subject) {
    TeachersMiddleWare.getAttendance(subject.subjectCode)
        .then((attendanceModel) {
      setState(() {
        _lectureAttendanceData = jsonDecode(attendanceModel.attendance);
      });
    });
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
          'View Lecture Attendance',
          style: GoogleFonts.getFont(
            'Outfit',
            color: AppColors.isabelline,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
        elevation: 2,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Hey,",
            style: GoogleFonts.getFont(
              'Readex Pro',
              color: AppColors.spaceCadet,
              fontSize: 25,
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 10, 8, 10),
            child: Text(
              "- Prof. ${_teacher.teacherName} please select your subject from the below dropdown list !!\n- Once selected, subject attendance will be displayed.",
              style: GoogleFonts.getFont(
                'Outfit',
                color: AppColors.independence,
                fontSize: 16,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 10, 8, 10),
            child: DropdownButtonFormField<SubjectDetails>(
              items: subjects.map((SubjectDetails subject) {
                return DropdownMenuItem<SubjectDetails>(
                  value: subject,
                  child: Text(
                      "${subject.subjectName} - (${subject.year} - Sem ${subject.semester})"),
                );
              }).toList(),
              value: _subject,
              onChanged: (SubjectDetails? value) {
                setState(() {
                  _subject = value!;
                  _lectureAttendanceData = null;
                  _fetchParticularSubjectAttendance(_subject!);
                });
              },
              validator: (value) {
                if (value == null) {
                  return "Please select subject";
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Select Subject",
                labelStyle: GoogleFonts.getFont(
                  'Readex Pro',
                  textStyle: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 16,
                  ),
                ),
                hintStyle: GoogleFonts.getFont(
                  'Readex Pro',
                  textStyle: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 16,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.secondaryText,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.secondaryText,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.lightRed,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: AppColors.lightRed,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ),
          _lectureAttendanceData == null || _subject == null
              ? const Center(
                  child: Text("No Attendance Found"),
                )
              : AttendanceOverview(
                  lectureAttendanceData: _lectureAttendanceData!),
        ],
      ),
    );
  }
}
