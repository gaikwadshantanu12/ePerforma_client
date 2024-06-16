import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/models/hod/hod_details.dart';

class HodProfilePage extends StatelessWidget {
  const HodProfilePage({super.key});

  Widget _settingsItem(
      {required IconData icon, required String name, required String link}) {
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
    final HodDetailsModel hod =
        ModalRoute.of(context)!.settings.arguments as HodDetailsModel;
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
                hod.hodName,
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
            Text(hod.hodEmail, style: GoogleFonts.getFont('Readex Pro')),
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
                          padding: EdgeInsetsDirectional.fromSTEB(0, 30, 0, 12),
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
                          link: hod.hodMobileNumber,
                        ),
                        _settingsItem(
                          icon: Icons.edit,
                          name: 'Profile Settings',
                          link: 'Edit Profile',
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
