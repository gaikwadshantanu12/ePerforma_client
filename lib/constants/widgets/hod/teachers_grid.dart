import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/default_animation.dart';
import 'package:student_performance_monitoring_app/middleware/hod/hod_mw.dart';
import 'package:student_performance_monitoring_app/models/teacher/teacher_details.dart';

class TeachersGrid extends StatefulWidget {
  final String department;
  const TeachersGrid({super.key, required this.department});

  @override
  State<TeachersGrid> createState() => _TeachersGridState();
}

class _TeachersGridState extends State<TeachersGrid> {
  List<TeacherDetailsModel> _teachers = [];
  final RefreshController _refreshController = RefreshController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    _fetchData();
  }

  void _fetchData() {
    HodMiddleWare.fetchDepartmentWiseTeachers(widget.department)
        .then((teachersList) {
      setState(() {
        _teachers = teachersList;
        isLoading = false;
      });
    });
  }

  void _onRefresh() async {
    _fetchData();
    _refreshController.refreshCompleted();
  }

  void _showTeacherDialog(BuildContext context, TeacherDetailsModel teacher,
      double height, double width) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Teacher Information",
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
              teacher.teacherName,
              style: GoogleFonts.getFont(
                'Outfit',
                color: AppColors.spaceCadet,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: height * 0.01),
            Text(teacher.teacherEmail),
            SizedBox(height: height * 0.01),
            Text(teacher.teacherCollegeID),
          ],
        ),
        actions: [
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
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : SmartRefresher(
            controller: _refreshController,
            onRefresh: _onRefresh,
            enablePullDown: true,
            child: _teachers.isEmpty
                ? DefaultAnimationMessage(
                    animationFile:
                        "assets/lottie_animations/no_data_found.json",
                    animationMessage:
                        "Oopps !!! No teachers found for ${widget.department} department.",
                    deviceWidth: deviceWidth,
                    deviceHeight: deviceHeight,
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(10),
                    itemCount: _teachers.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => _showTeacherDialog(context,
                            _teachers[index], deviceHeight, deviceWidth),
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
                                _teachers[index].teacherName,
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
