import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/session_manager.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/single_card_item.dart';
import 'package:student_performance_monitoring_app/middleware/teachers/teacher_mw.dart';
import 'package:student_performance_monitoring_app/models/batches/batch_detail.dart';
import 'package:student_performance_monitoring_app/models/class/class_details.dart';
import 'package:student_performance_monitoring_app/models/teacher/teacher_details.dart';
import '../../constants/colors.dart';

class TeacherDashboardPage extends StatefulWidget {
  const TeacherDashboardPage({super.key});

  @override
  State<TeacherDashboardPage> createState() => _TeacherDashboardPageState();
}

class _TeacherDashboardPageState extends State<TeacherDashboardPage> {
  late TeacherDetailsModel teacher;
  ClassDetails? _classDetails;
  BatchDetails? _batchDetails;
  late bool isClassTeacher;
  late bool isBatchMentor;

  @override
  void initState() {
    super.initState();
    isClassTeacher = false;
    isBatchMentor = false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    teacher = ModalRoute.of(context)!.settings.arguments as TeacherDetailsModel;
    checkForClassTeacher();
    checkForBatchMentor();
  }

  void checkForClassTeacher() {
    TeachersMiddleWare.isClassTeacher(teacher.teacherCollegeID)
        .then((bool result) {
      setState(() {
        isClassTeacher = result;

        if (isClassTeacher) {
          fetchClassDetailsForClassTeacher();
        }
      });
    });
  }

  void checkForBatchMentor() {
    TeachersMiddleWare.isBatchMentor(teacher.teacherCollegeID)
        .then((bool result) {
      setState(() {
        isBatchMentor = result;

        if (isBatchMentor) {
          fetchbatchDetailsForClassTeacher();
        }
      });
    });
  }

  void fetchClassDetailsForClassTeacher() {
    TeachersMiddleWare.fetchClassByTeacherID(teacher.teacherCollegeID)
        .then((classDetails) {
      setState(() {
        _classDetails = classDetails;
      });
    });
  }

  void fetchbatchDetailsForClassTeacher() {
    TeachersMiddleWare.fetchBatchByTeacherID(teacher.teacherCollegeID)
        .then((batchDetails) {
      setState(() {
        _batchDetails = batchDetails;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: AppColors.spaceCadet,
        automaticallyImplyLeading: false,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: AppColors.spaceCadet),
        title: Text(
          'Teacher\'s Dashboard',
          style: GoogleFonts.getFont(
            'Outfit',
            color: AppColors.isabelline,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
        elevation: 2,
        actions: [
          Align(
            alignment: const AlignmentDirectional(0, 0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
              child: IconButton(
                icon: const Icon(
                  Icons.logout,
                  size: 24,
                  color: AppColors.isabelline,
                ),
                onPressed: () {
                  SessionManager.setGlobalAppRole('');
                  SessionManager.logoutTeacher();
                  Navigator.pushReplacementNamed(context, '/welcome_screen');
                },
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Align(
                  alignment: const AlignmentDirectional(0, -1),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, '/teacher/teacher_profile_page',
                              arguments: teacher);
                        },
                        child: SingleCardItem(
                          cardText: "My Profile",
                          cardImage:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGnMBznsXiF3d24T0m-uEgiQUkjPeutggHKw&usqp=CAU',
                          width: width,
                          height: height,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, '/teacher/view_official_notices',
                              arguments: teacher);
                        },
                        child: SingleCardItem(
                          cardText: "Notices",
                          cardImage:
                              'https://imgs.search.brave.com/CPkXOYx-r4OM-S3v5oj3wOf2hJ6R3-iHSLT7WpU3wSc/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/ZnJlZS1waG90by8z/ZC1yZW5kZXItbWVn/YXBob25lLWxvdWRz/cGVha2VyLXdpdGgt/Zmxhc2hlc18xMDc3/OTEtMTczNDUuanBn',
                          width: width,
                          height: height,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0, -1),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, '/teacher/lecture_attendance',
                                arguments: teacher);
                          },
                          child: SingleCardItem(
                            cardText: 'Lecture Attendance',
                            cardImage:
                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSY79XARUFPkF5NpJUkQfoREI-hrvRODWD24g&usqp=CAU',
                            width: width,
                            height: height,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                isBatchMentor
                    ? Column(
                        children: [
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0, -1),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 20, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Batch Mentor's Section",
                                    style: GoogleFonts.getFont(
                                      'Outfit',
                                      color: AppColors.spaceCadet,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Text(
                                    "Remember only those teacher can see this section to whom HOD has assigned then as Batch Teacher of Particular Batch",
                                    style: GoogleFonts.getFont(
                                      'Outfit',
                                      color: AppColors.spaceCadet,
                                      fontSize: 15,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                          _batchDetails != null
                              ? Align(
                                  alignment: const AlignmentDirectional(0, -1),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              '/teacher/view_batch_students',
                                              arguments: _batchDetails!,
                                            );
                                          },
                                          child: SingleCardItem(
                                            cardText:
                                                '${_batchDetails!.year} - ${_batchDetails!.section} (${_batchDetails!.startingRollNo} - ${_batchDetails!.endingRollNo}) Students',
                                            cardImage:
                                                'https://imgs.search.brave.com/kTchEAZz9dmmQUoaA0VQo3MDfm-Gcot-gzzwmkbpWnM/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9zbWFs/bGltZy5wbmdrZXku/Y29tL3BuZy9zbWFs/bC80MDAtNDAwMzY4/MF9yZWdpc3RyYXRp/b24tZm9yLXVuZGVy/LWdyYWR1YXRlLXN0/dWRlbnQtaWNvbi1w/bmcucG5n',
                                            width: width,
                                            height: height,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              '/teacher/broadcast_message',
                                              arguments: _batchDetails!,
                                            );
                                          },
                                          child: SingleCardItem(
                                            cardText: 'Broadcast Message',
                                            cardImage:
                                                'https://imgs.search.brave.com/qGuxzrw1qCDPfEkN9fv8XyFj56Qehk29c9vOM2UTJpE/rs:fit:860:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzAyLzAzLzk4LzE5/LzM2MF9GXzIwMzk4/MTkxM19NRG5mTThM/bTluREFIMnh3c3kw/b2tjekltUFVmNktG/Si5qcGc',
                                            width: width,
                                            height: height,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      )
                    : Container(),
                isClassTeacher
                    ? Column(
                        children: [
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0, -1),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 20, 0, 0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Class Teacher's Section",
                                    style: GoogleFonts.getFont(
                                      'Outfit',
                                      color: AppColors.spaceCadet,
                                      fontSize: 22,
                                    ),
                                  ),
                                  Text(
                                    "Remember only those teacher can see this section to whom HOD has assigned then as Class Teacher of Particular Year/Division",
                                    style: GoogleFonts.getFont(
                                      'Outfit',
                                      color: AppColors.spaceCadet,
                                      fontSize: 15,
                                      fontStyle: FontStyle.italic,
                                    ),
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),
                          ),
                          _classDetails != null
                              ? Align(
                                  alignment: const AlignmentDirectional(0, -1),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                            0, 20, 0, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              '/teacher/class_teacher_view_class_attendance',
                                              arguments: _classDetails!,
                                            );
                                          },
                                          child: SingleCardItem(
                                            cardText:
                                                '${_classDetails!.year} - ${_classDetails!.section} Attendance',
                                            cardImage:
                                                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSY79XARUFPkF5NpJUkQfoREI-hrvRODWD24g&usqp=CAU',
                                            width: width,
                                            height: height,
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Navigator.pushNamed(
                                              context,
                                              '/teacher/class_teacher_view_class_students',
                                              arguments: _classDetails!,
                                            );
                                          },
                                          child: SingleCardItem(
                                            cardText:
                                                '${_classDetails!.year} - ${_classDetails!.section} Students',
                                            cardImage:
                                                'https://imgs.search.brave.com/kTchEAZz9dmmQUoaA0VQo3MDfm-Gcot-gzzwmkbpWnM/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9zbWFs/bGltZy5wbmdrZXku/Y29tL3BuZy9zbWFs/bC80MDAtNDAwMzY4/MF9yZWdpc3RyYXRp/b24tZm9yLXVuZGVy/LWdyYWR1YXRlLXN0/dWRlbnQtaWNvbi1w/bmcucG5n',
                                            width: width,
                                            height: height,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      )
                    : Container()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
