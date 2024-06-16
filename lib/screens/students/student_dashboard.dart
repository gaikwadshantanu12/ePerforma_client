import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/constants/session_manager.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/single_card_item.dart';
import 'package:student_performance_monitoring_app/models/student/student_details.dart';

class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final StudentDetailsModel student =
        ModalRoute.of(context)!.settings.arguments as StudentDetailsModel;
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
          'Student Dashboard',
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
                  SessionManager.logoutStudent();
                  Navigator.pushReplacementNamed(context, '/welcome_screen');
                },
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: true,
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, '/student/student_profile_page',
                            arguments: student);
                      },
                      child: SingleCardItem(
                        cardText: "My Profile",
                        cardImage:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGnMBznsXiF3d24T0m-uEgiQUkjPeutggHKw&usqp=CAU',
                        width: width,
                        height: height,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                            context, '/student/student_academics_page',
                            arguments: student);
                      },
                      child: SingleCardItem(
                        cardText: "Academics",
                        cardImage:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSu2eoiUdo6hfmhpKqH86oyvzfMv9VAvdvCbQ&usqp=CAU',
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
                      SingleCardItem(
                        cardText: 'Attendance',
                        cardImage:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSY79XARUFPkF5NpJUkQfoREI-hrvRODWD24g&usqp=CAU',
                        width: width,
                        height: height,
                      ),
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, '/student/view_notices_page',
                            arguments: student.studentDepartment),
                        child: SingleCardItem(
                          cardText: 'Official Notices',
                          cardImage:
                              'https://ourstartupindia.com/wp-content/uploads/2023/06/public-930x620.jpg',
                          width: width,
                          height: height,
                        ),
                      )
                    ],
                  ),
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
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, '/student/student_useful_links');
                        },
                        child: SingleCardItem(
                          cardText: 'Useful Links',
                          cardImage:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFGbprl8nify2ZUXxajT2ktDwkT4jnYwhwFQ&usqp=CAU',
                          width: width,
                          height: height,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
