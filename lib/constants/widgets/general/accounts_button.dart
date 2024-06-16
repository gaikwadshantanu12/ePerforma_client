import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';

class AccountButton extends StatelessWidget {
  final String buttonText;
  final Icon buttonIcon;
  final VoidCallback buttonClicked;

  const AccountButton(
      {super.key,
      required this.buttonText,
      required this.buttonIcon,
      required this.buttonClicked});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0, 0),
      child: ElevatedButton.icon(
        onPressed: buttonClicked,
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 10, 24, 10),
            backgroundColor: AppColors.independence,
            elevation: 3,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(20),
            )),
        label: Text(
          buttonText,
          style: GoogleFonts.getFont(
            'Readex Pro',
            textStyle: const TextStyle(color: AppColors.isabelline),
          ),
        ),
        icon: buttonIcon,
      ),
    );
  }
}
