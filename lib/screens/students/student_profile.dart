import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/models/student/student_details.dart';

class StudentProfilePage extends StatelessWidget {
  const StudentProfilePage({super.key});

  Widget _quickMenus(
      {required String quickTitlename, required IconData quickTitleIcon}) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
            child: Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: AppColors.freshWhite,
                shape: BoxShape.circle,
              ),
              alignment: const AlignmentDirectional(0, 0),
              child: Icon(
                quickTitleIcon,
                color: Colors.black87,
                size: 24,
              ),
            ),
          ),
          Text(
            quickTitlename,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _settingsItem({
    required IconData icon,
    required String name,
    required String link,
  }) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 8, 16, 8),
            child: Icon(
              icon,
              color: AppColors.secondaryText,
              size: 24,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
              child: Text(
                name,
                textAlign: TextAlign.start,
              ),
            ),
          ),
          Text(
            link,
            textAlign: TextAlign.center,
            style: GoogleFonts.getFont(
              'Readex Pro',
              textStyle: const TextStyle(
                color: AppColors.lightRed,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final StudentDetailsModel student =
        ModalRoute.of(context)!.settings.arguments as StudentDetailsModel;

    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.spaceCadet,
        automaticallyImplyLeading: true,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: AppColors.spaceCadet),
        title: Text(
          'My Profile',
          style: GoogleFonts.getFont(
            'Outfit',
            color: AppColors.isabelline,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
        elevation: 2,
      ),
      body: Align(
        alignment: const AlignmentDirectional(0, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: deviceWidth * 0.5,
              height: deviceHeight * 0.23,
              margin: const EdgeInsets.only(top: 20),
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: Image.network(
                'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 16, 0, 12),
              child: Text(
                student.studentName,
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  'Outfit',
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Text(student.studentPersonalEmail,
                style: GoogleFonts.getFont('Readex Pro')),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 24, 16, 32),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/student/upload_documents',
                      arguments: student.studentCollegeID,
                    ),
                    child: _quickMenus(
                      quickTitlename: "Upload Documents",
                      quickTitleIcon: Icons.upload_file_outlined,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/student/view_documents',
                      arguments: student.studentCollegeID,
                    ),
                    child: _quickMenus(
                      quickTitlename: "View Documents",
                      quickTitleIcon: Icons.document_scanner,
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 12),
                          child: Text(
                            'Settings',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                                color: AppColors.spaceCadet),
                          ),
                        ),
                        _settingsItem(
                          icon: Icons.phone,
                          name: 'Phone Number',
                          link: '+91-${student.studentMobile}',
                        ),
                        InkWell(
                          onTap: () => Navigator.pushNamed(
                            context,
                            "/student/social_connect",
                            arguments: student.studentCollegeID,
                          ),
                          child: _settingsItem(
                            icon: Icons.insert_link_outlined,
                            name: 'Social Links',
                            link: 'Connect Me',
                          ),
                        ),
                        InkWell(
                          onTap: () => Navigator.pushNamed(
                            context,
                            "/student/edit_profile_page",
                            arguments: student.studentCollegeID,
                          ),
                          child: _settingsItem(
                            icon: Icons.edit,
                            name: 'Profile Settings',
                            link: 'Edit Profile',
                          ),
                        ),
                        _settingsItem(
                          icon: Icons.login_rounded,
                          name: 'Logout Account',
                          link: 'Logout',
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
