import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      backgroundColor: AppColors.isabelline,
      body: SafeArea(
        top: true,
        child: Container(
          width: screenWidth * 0.3,
          height: screenHeight * 0.7,
          constraints: const BoxConstraints(
            minWidth: double.infinity,
            minHeight: double.infinity,
            maxWidth: double.infinity,
            maxHeight: double.infinity,
          ),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.isabelline, AppColors.silverPink],
              stops: [0.5, 1],
              begin: AlignmentDirectional(-0.34, -1),
              end: AlignmentDirectional(0.34, 1),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GradientText(
                'Welcome to ePerforma',
                textAlign: TextAlign.center,
                style: GoogleFonts.getFont(
                  'Roboto',
                  fontWeight: FontWeight.bold,
                  fontSize: screenWidth * 0.09,
                ),
                colors: const [AppColors.spaceCadet, AppColors.independence],
                gradientDirection: GradientDirection.ttb,
                gradientType: GradientType.linear,
              ),
              Text(
                '~ Student Monitoring & Performance App',
                style: GoogleFonts.getFont(
                  'Readex Pro',
                  textStyle: TextStyle(
                    fontSize: screenWidth * 0.04,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, 0),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(50, 50, 50, 50),
                  child: Container(
                    width: screenWidth * 0.7,
                    height: screenHeight * 0.35,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/app_logo.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, 1),
                child: SizedBox(
                  height: screenHeight * 0.065,
                  width: screenWidth * 0.5,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Navigator.pushNamed(context, '/role_selector_page');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.spaceCadet,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(30, 0, 30, 0),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                        side: const BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                      ),
                    ),
                    icon: Icon(
                      Icons.forward_rounded,
                      size: screenWidth * 0.05,
                    ),
                    label: Text(
                      "Get Started",
                      style: GoogleFonts.getFont('Readex Pro'),
                    ),
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
