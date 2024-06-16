import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/accounts_button.dart';
import 'package:student_performance_monitoring_app/middleware/teachers/teacher_mw.dart';
import 'package:student_performance_monitoring_app/models/lecture_attendance/lecture_attendance_model.dart';
import 'package:student_performance_monitoring_app/models/student/student_details.dart';
import 'package:student_performance_monitoring_app/models/subject/subject_details.dart';
import 'package:student_performance_monitoring_app/models/teacher/teacher_details.dart';

class LectureAttendance extends StatefulWidget {
  const LectureAttendance({super.key});

  @override
  State<LectureAttendance> createState() => _LectureAttendanceState();
}

class _LectureAttendanceState extends State<LectureAttendance> {
  SubjectDetails? _subject;
  List<SubjectDetails> subjects = [];
  List<StudentDetailsModel> _students = [];
  late TeacherDetailsModel _teacher;
  final _formKey = GlobalKey<FormState>();
  bool _isDataLoaded = false;
  DateTime _selectedDate = DateTime.now();
  // Map<String, Map<String, Map<String, dynamic>>> attendance = {};
  Map<String, dynamic> attendance = {};
  List<String> selectedStudents = [];
  bool isAttendanceEmpty = true;

  @override
  void initState() {
    super.initState();
    _isDataLoaded = false;
    isAttendanceEmpty = true;
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

  void _fetchStudentsData() {
    TeachersMiddleWare.fetchStudentsByYearSectionAndDepartment(
            _subject!.year, _subject!.section, _subject!.department)
        .then((studentList) {
      setState(() {
        _students = studentList;
        _isDataLoaded = true;
      });
    });
  }

  void _fetchPrevioudSubjectAttendance() {
    TeachersMiddleWare.getAttendance(_subject!.subjectCode)
        .then((attendanceJSON) {
      setState(() {
        attendance = jsonDecode(attendanceJSON.attendance);
        if (attendance.isNotEmpty) {
          isAttendanceEmpty = false;
        }
      });
    });
  }

  void _selectDate(BuildContext context) async {
    DateTime today = DateTime.now();
    DateTime fiveDaysAgo = today.subtract(const Duration(days: 5));

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: fiveDaysAgo, // Disable dates older than 5 days
      lastDate: today,
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.spaceCadet, // Header color
              onPrimary: AppColors.isabelline, // Header text color
              surface: Colors.deepPurpleAccent, // Calendar tile color
              onSurface: Colors.black, // Calendar text color
            ),
            dialogBackgroundColor: Colors.white, // Dialog background color
          ),
          child: child!,
        );
      }, // Disable future dates
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
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
          'Lecture Attendance',
          style: GoogleFonts.getFont(
            'Outfit',
            color: AppColors.isabelline,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
        elevation: 2,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/teacher/view_lecture_attendance',
              arguments: _teacher);
        },
        backgroundColor: AppColors.spaceCadet, // Background color of the button
        foregroundColor: AppColors.isabelline,

        child: const Icon(Icons.remove_red_eye),
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Form(
                  key: _formKey,
                  child: Column(
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
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 10, 8, 10),
                        child: Text(
                          "- Prof. ${_teacher.teacherName} please select your subject from the below dropdown list !!\n- Once selected, corresponding year students w.r.t subject will be loaded !",
                          style: GoogleFonts.getFont(
                            'Outfit',
                            color: AppColors.independence,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 10, 8, 10),
                        child: DropdownButtonFormField<SubjectDetails>(
                          items: subjects.map((SubjectDetails subject) {
                            return DropdownMenuItem<SubjectDetails>(
                              value: subject,
                              child: Text(
                                  "${subject.subjectName} - (${subject.year} - ${subject.section} - Sem ${subject.semester})"),
                            );
                          }).toList(),
                          value: _subject,
                          onChanged: (SubjectDetails? value) {
                            setState(() {
                              _subject = value!;
                            });
                            _fetchPrevioudSubjectAttendance();
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
                      AccountButton(
                        buttonText: "Set Subject & Load Students",
                        buttonIcon: const Icon(Icons.data_exploration),
                        buttonClicked: () {
                          if (_formKey.currentState!.validate()) {
                            _fetchStudentsData();
                          }
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: deviceHeight * 0.05,
                ),
                _isDataLoaded
                    ? Column(
                        children: [
                          Container(
                            height: deviceHeight * 0.5,
                            decoration: BoxDecoration(
                              color: AppColors.isabelline,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: GridView.builder(
                              padding: const EdgeInsets.all(10),
                              itemCount: _students.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (selectedStudents.contains(
                                          _students[index].studentCollegeID)) {
                                        selectedStudents.remove(
                                            _students[index].studentCollegeID);
                                      } else {
                                        selectedStudents.add(
                                            _students[index].studentCollegeID);
                                      }
                                    });
                                  },
                                  onLongPress: () =>
                                      TeachersMiddleWare.showStudentInfoPopup(
                                          _students[index], context),
                                  child: ClipOval(
                                    child: Container(
                                      height: deviceHeight * 0.2,
                                      width: deviceWidth * 0.1,
                                      decoration: BoxDecoration(
                                        color: selectedStudents.contains(
                                                _students[index]
                                                    .studentCollegeID)
                                            ? AppColors.green
                                            : AppColors.silverPink,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: ListTile(
                                        title: Center(
                                          child: Text(
                                            _students[index]
                                                .studentRollNo
                                                .toString(),
                                            style: GoogleFonts.getFont(
                                              'Outfit',
                                              textStyle: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: deviceHeight * 0.05,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AccountButton(
                                buttonText: 'Mark Attendance',
                                buttonIcon: const Icon(Icons.store_rounded),
                                buttonClicked: () {
                                  setState(() async {
                                    final result = await showDialog<bool>(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text('Confirmation'),
                                        content: Text(
                                            "Are you sure you want to mark attendance for the date ${_selectedDate.toString().split(" ")[0]} ?"),
                                        actions: [
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, false), // Cancel
                                            child: const Text('No'),
                                          ),
                                          TextButton(
                                            onPressed: () => Navigator.pop(
                                                context, true), // Confirm
                                            child: const Text('Yes'),
                                          ),
                                        ],
                                      ),
                                    );

                                    if (result ?? false) {
                                      DateTime formattedDate = DateTime(
                                        _selectedDate.year,
                                        _selectedDate.month,
                                        _selectedDate.day,
                                      );

                                      // Create formatted date string for the current day
                                      String formattedDateString = formattedDate
                                          .toString()
                                          .split(" ")[0];

                                      // Ensure the attendance map for the current date exists
                                      attendance[formattedDateString] ??= {};

                                      for (var student in _students) {
                                        final studentId =
                                            student.studentCollegeID;

                                        // Initialize student's attendance record for the current date if it doesn't exist
                                        attendance[formattedDateString]![
                                            studentId] ??= {
                                          "totalLecturesTillDate": 0,
                                          "presentLecturesTillDate": 0,
                                          "presentForToday": false
                                        };

                                        // Get current attendance data for the student
                                        var studentAttendance = attendance[
                                            formattedDateString]![studentId]!;

                                        // Increment total lectures count
                                        studentAttendance[
                                                "totalLecturesTillDate"] =
                                            (studentAttendance[
                                                        "totalLecturesTillDate"]
                                                    as int) +
                                                1;

                                        // Check if the student is marked present for today
                                        bool isPresentToday = selectedStudents
                                            .contains(studentId);
                                        studentAttendance["presentForToday"] =
                                            isPresentToday;

                                        // Increment present lectures count if student is present today
                                        if (isPresentToday) {
                                          studentAttendance[
                                                  "presentLecturesTillDate"] =
                                              (studentAttendance[
                                                          "presentLecturesTillDate"]
                                                      as int) +
                                                  1;
                                        }
                                      }

                                      // Use a JSON encoder to format the attendance data with indentation
                                      const encoder = JsonEncoder.withIndent(
                                          '  '); // Use two spaces for indentation
                                      final jsonAttendanceString =
                                          encoder.convert(attendance);

                                      // Create the lecture attendance model and post the attendance
                                      LectureAttendanceModel model =
                                          LectureAttendanceModel(
                                        subjectCode: _subject!.subjectCode,
                                        attendance: jsonAttendanceString,
                                      );
                                      TeachersMiddleWare.postAttendance(model);

                                      // Clear the selected students
                                      selectedStudents.clear();
                                    }
                                  });
                                },
                              ),
                              IconButton(
                                onPressed: () => _selectDate(context),
                                icon: const Icon(Icons.date_range_rounded),
                              )
                            ],
                          ),
                          SizedBox(
                            height: deviceHeight * 0.05,
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
