import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';

class RoleSelectedPage extends StatelessWidget {
  const RoleSelectedPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;
    double screenHeight = MediaQuery.sizeOf(context).height;

    // print("Screen Width : $screenWidth, Screen height : $screenHeight");

    Widget singleQuote(
        {required String quote,
        required Color textColor,
        required double start,
        required double y,
        required double fontSize}) {
      return Align(
        alignment: AlignmentDirectional(start, y),
        child: Text(
          quote,
          textAlign: TextAlign.center,
          style: GoogleFonts.getFont(
            'Readex Pro',
            textStyle: TextStyle(
              color: textColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }

    Widget roleSelectorButton(
        {required String buttonText, required GestureTapCallback onPressed}) {
      return SizedBox(
        width: screenWidth * 0.5,
        height: screenHeight * 0.06,
        child: ElevatedButton.icon(
          onPressed: onPressed,
          icon: const Icon(
            Icons.person_2_rounded,
            size: 15,
            color: AppColors.darkBlack,
          ),
          label: Text(
            buttonText,
            style: GoogleFonts.getFont(
              'Readex Pro',
              textStyle: const TextStyle(
                color: AppColors.darkBlack,
              ),
            ),
          ),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: const BorderSide(
                color: AppColors.secondaryText,
                width: 1,
              ),
            ),
            backgroundColor: AppColors.primaryBackground,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.middleYellowRed,
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: AppColors.middleYellowRed),
        title: Text(
          'Welcome to ePerforma',
          style: GoogleFonts.getFont(
            'Outfit',
            color: AppColors.darkBlack,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: screenHeight * 0.5,
                  child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      singleQuote(
                          quote: "Who are you ??",
                          textColor: AppColors.coffee,
                          start: -1,
                          y: 0,
                          fontSize: 20),
                      singleQuote(
                          quote: "Ummmm, Let me guess !",
                          textColor: AppColors.cafeAulait,
                          start: -1,
                          y: 0,
                          fontSize: 20),
                      Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              15, 15, 15, 15),
                          child: Container(
                            width: screenWidth * 0.7,
                            height: screenHeight * 0.23,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              'https://img.freepik.com/premium-vector/confused-man-with-question-mark-scratching-head_199628-270.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      singleQuote(
                          quote: "Oops, sorry !!",
                          textColor: AppColors.coffee,
                          start: 1,
                          y: 0,
                          fontSize: 20),
                      singleQuote(
                          quote: "I\'m unable to do.",
                          textColor: AppColors.cafeAulait,
                          start: 1,
                          y: 0,
                          fontSize: 22),
                      Align(
                        alignment: const AlignmentDirectional(-1, 0),
                        child: Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
                          child: Text(
                            'Please Select Your Role...',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.getFont(
                              'Readex Pro',
                              textStyle: const TextStyle(
                                color: AppColors.coffee,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
            child: Material(
              color: Colors.transparent,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: screenWidth * 0.6,
                height: screenHeight * 0.3,
                constraints: const BoxConstraints(
                  minWidth: double.infinity,
                  maxWidth: double.infinity,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryBackground,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Align(
                  alignment: const AlignmentDirectional(0, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      roleSelectorButton(
                        buttonText: "Student",
                        onPressed: () {
                          Navigator.pushNamed(
                              context, '/student_authentication_page');
                        },
                      ),
                      roleSelectorButton(
                        buttonText: "Teacher",
                        onPressed: () {
                          Navigator.pushNamed(
                              context, '/teacher_authentication_page');
                        },
                      ),
                      roleSelectorButton(
                        buttonText: "Admin",
                        onPressed: () {
                          print("Admin Pressed");
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
