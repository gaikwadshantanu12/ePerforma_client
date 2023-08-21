import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  Widget _singleCard(
      {required String cardText,
      required String cardImage,
      required double width,
      required double height}) {
    return Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: AppColors.freshWhite,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: width * 0.4,
        height: height * 0.2,
        decoration: const BoxDecoration(
          color: AppColors.freshWhite,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: width * 0.28,
              height: height * 0.1,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(
                cardImage,
                fit: BoxFit.cover,
              ),
            ),
            Text(
              cardText,
              style: GoogleFonts.getFont(
                'Readex Pro',
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
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
                    _singleCard(
                      cardText: "My Profile",
                      cardImage:
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGnMBznsXiF3d24T0m-uEgiQUkjPeutggHKw&usqp=CAU',
                      width: width,
                      height: height,
                    ),
                    _singleCard(
                      cardText: "Academics",
                      cardImage:
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSu2eoiUdo6hfmhpKqH86oyvzfMv9VAvdvCbQ&usqp=CAU',
                      width: width,
                      height: height,
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
                      _singleCard(
                        cardText: 'Attendance',
                        cardImage:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSY79XARUFPkF5NpJUkQfoREI-hrvRODWD24g&usqp=CAU',
                        width: width,
                        height: height,
                      ),
                      _singleCard(
                        cardText: 'Official Notices',
                        cardImage:
                            'https://ourstartupindia.com/wp-content/uploads/2023/06/public-930x620.jpg',
                        width: width,
                        height: height,
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
                          Navigator.pushNamed(context, '/student_useful_links');
                        },
                        child: _singleCard(
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
