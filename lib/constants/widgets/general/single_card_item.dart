import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';

class SingleCardItem extends StatelessWidget {
  final String cardText, cardImage;
  final double width, height;
  const SingleCardItem(
      {super.key,
      required this.cardText,
      required this.cardImage,
      required this.width,
      required this.height});

  @override
  Widget build(BuildContext context) {
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
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
