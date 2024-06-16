import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/attendance_summary.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/accounts_button.dart';
import 'package:student_performance_monitoring_app/middleware/hod/hod_mw.dart';
import 'package:student_performance_monitoring_app/models/subject/subject_details.dart';

class AttendanceInsights extends StatefulWidget {
  final String year;
  final String department;
  const AttendanceInsights(
      {super.key, required this.year, required this.department});

  @override
  State<AttendanceInsights> createState() => _AttendanceInsightsState();
}

class _AttendanceInsightsState extends State<AttendanceInsights> {
  List<SubjectDetails> _subjects = [];
  SubjectDetails? _subject;
  bool isLoading = true;
  Map<String, dynamic>? _lectureAttendanceData;

  @override
  void initState() {
    super.initState();
    isLoading = true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _fetchSubjects();
  }

  void _fetchSubjects() {
    HodMiddleWare.fetchAllSubjectsByYearAndDepartment(
            widget.department, widget.year)
        .then((subjectsList) {
      setState(() {
        _subjects = subjectsList;
        isLoading = false;
      });
    });
  }

  void _fetchParticularSubjectAttendance(SubjectDetails subject) {
    HodMiddleWare.getSubjectAttendance(subject.subjectCode)
        .then((attendanceModel) {
      setState(() {
        _lectureAttendanceData = jsonDecode(attendanceModel.attendance);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : _subjects.isNotEmpty
            ? Column(
                children: [
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 10, 8, 10),
                    child: DropdownButtonFormField<SubjectDetails>(
                      items: _subjects.map((SubjectDetails subject) {
                        return DropdownMenuItem<SubjectDetails>(
                          value: subject,
                          child: Text(
                              "${subject.subjectName} - ${subject.subjectCode}"),
                        );
                      }).toList(),
                      value: _subject,
                      onChanged: (SubjectDetails? value) {
                        setState(() {
                          _subject = value!;
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
                  SizedBox(
                    height: height * 0.02,
                  ),
                  _subject != null
                      ? AccountButton(
                          buttonText: "Show Attendance",
                          buttonIcon: const Icon(Icons.remove_red_eye),
                          buttonClicked: () {
                            setState(() {
                              _lectureAttendanceData = null; // Reset data
                            });
                            _fetchParticularSubjectAttendance(_subject!);
                          })
                      : Container(),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  _lectureAttendanceData != null
                      ? AttendanceOverview(
                          lectureAttendanceData: _lectureAttendanceData!)
                      : const Center(
                          child: Text("No Attendance Found"),
                        )
                ],
              )
            : Center(
                child: Text(
                  "No subjects found for ${widget.year}. Please allot subject(s) and subject teacher(s) for the same.",
                  style: GoogleFonts.getFont(
                    'Readex Pro',
                    textStyle: const TextStyle(
                      color: AppColors.spaceCadet,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  textAlign: TextAlign.center,
                ),
              );
  }
}
