import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/constants/widgets/student/student_create_account.dart';
import 'package:student_performance_monitoring_app/constants/widgets/student/student_login.dart';

class StudentAuthenticationPage extends StatefulWidget {
  const StudentAuthenticationPage({super.key});

  @override
  State<StudentAuthenticationPage> createState() =>
      _StudentAuthenticationPageState();
}

class _StudentAuthenticationPageState extends State<StudentAuthenticationPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
          'Student Authentication',
          style: GoogleFonts.getFont(
            'Outfit',
            textStyle: const TextStyle(
              color: AppColors.isabelline,
              fontSize: 22,
            ),
          ),
        ),
        centerTitle: false,
        elevation: 2,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'Create Account',
            ),
            Tab(
              text: 'Login',
            ),
          ],
          unselectedLabelColor: AppColors.heliotropeGray,
          indicatorColor: AppColors.spaceCadet,
          indicatorWeight: 2,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [StudentCreateAccount(), StudentLogin()],
      ),
    );
  }
}
