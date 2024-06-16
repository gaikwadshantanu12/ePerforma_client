import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';

class DefaultAnimationMessage extends StatelessWidget {
  final String animationFile;
  final String animationMessage;
  final double deviceWidth;
  final double deviceHeight;

  const DefaultAnimationMessage(
      {super.key,
      required this.animationFile,
      required this.animationMessage,
      required this.deviceWidth,
      required this.deviceHeight});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Lottie.asset(
          animationFile,
          width: deviceWidth * 0.75,
          height: deviceHeight * 0.3,
          fit: BoxFit.cover,
          animate: true,
        ),
        Text(
          animationMessage,
          textAlign: TextAlign.center,
          style: GoogleFonts.getFont(
            'Readex Pro',
            fontSize: 20,
            textStyle: const TextStyle(
              color: AppColors.spaceCadet,
            ),
          ),
        ),
      ],
    );
  }
}
