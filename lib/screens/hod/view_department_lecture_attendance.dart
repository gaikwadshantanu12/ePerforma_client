import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/constants/widgets/hod/attendance_insights.dart';

class ViewDepartmentLectureAttendance extends StatefulWidget {
  const ViewDepartmentLectureAttendance({super.key});

  @override
  State<ViewDepartmentLectureAttendance> createState() =>
      _ViewDepartmentLectureAttendanceState();
}

class _ViewDepartmentLectureAttendanceState
    extends State<ViewDepartmentLectureAttendance>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late String _department;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _department = ModalRoute.of(context)?.settings.arguments as String;
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
          'Attendance Insights',
          style: GoogleFonts.getFont(
            'Outfit',
            color: AppColors.isabelline,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
        elevation: 2,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'SE',
            ),
            Tab(
              text: 'TE',
            ),
            Tab(
              text: 'BE',
            ),
          ],
          unselectedLabelColor: AppColors.heliotropeGray,
          indicatorColor: AppColors.spaceCadet,
          indicatorWeight: 2,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          AttendanceInsights(
            year: "SE",
            department: _department,
          ),
          AttendanceInsights(
            year: "TE",
            department: _department,
          ),
          AttendanceInsights(
            year: "BE",
            department: _department,
          )
        ],
      ),
    );
  }
}
