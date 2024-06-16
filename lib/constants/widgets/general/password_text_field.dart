import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:student_performance_monitoring_app/constants/colors.dart';

// ignore: must_be_immutable
class PasswordTextField extends StatefulWidget {
  final TextEditingController contoller;
  bool obscureText;
  final String labelText;
  final String? Function(String?) validator;

  PasswordTextField({
    Key? key,
    required this.contoller,
    required this.obscureText,
    required this.labelText,
    required this.validator,
  }) : super(key: key);

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(8, 10, 8, 10),
      child: TextFormField(
          controller: widget.contoller,
          obscureText: !widget.obscureText,
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: GoogleFonts.getFont(
              'Readex Pro',
              textStyle: const TextStyle(
                fontSize: 16,
                color: AppColors.secondaryText,
              ),
            ),
            hintStyle: GoogleFonts.getFont('Readex Pro',
                textStyle: const TextStyle(fontSize: 16)),
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
            suffixIcon: InkWell(
              onTap: () => setState(
                () => widget.obscureText = !widget.obscureText,
              ),
              focusNode: FocusNode(skipTraversal: true),
              child: Icon(
                widget.obscureText
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: AppColors.secondaryText,
                size: 25,
              ),
            ),
          ),
          style: GoogleFonts.getFont(
            'Readex Pro',
            textStyle: const TextStyle(
              fontSize: 16,
            ),
          ),
          keyboardType: TextInputType.visiblePassword,
          cursorColor: AppColors.secondaryText,
          validator: widget.validator),
    );
  }
}
