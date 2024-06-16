import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';

class NormalTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? keyboardType;
  final String? Function(String?) validator;
  final Function(String?) onChanged;
  const NormalTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      this.keyboardType,
      required this.validator,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(8, 10, 8, 10),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        textCapitalization: TextCapitalization.none,
        obscureText: false,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: GoogleFonts.getFont(
            'Readex Pro',
            textStyle: const TextStyle(
              color: AppColors.secondaryText,
              fontSize: 16,
            ),
          ),
          hintStyle: GoogleFonts.getFont(
            'Readex Pro',
            textStyle: const TextStyle(
              fontSize: 16,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.secondaryText,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.secondaryText,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.lightRed,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColors.lightRed,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        style: GoogleFonts.getFont(
          'Readex Pro',
          textStyle: const TextStyle(fontSize: 16),
        ),
        validator: validator,
        keyboardType: keyboardType,
        minLines: 1,
        cursorColor: AppColors.secondaryText,
      ),
    );
  }
}
