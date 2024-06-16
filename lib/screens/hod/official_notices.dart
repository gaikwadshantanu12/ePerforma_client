import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/constants/widgets/hod/show_notices.dart';
import 'package:student_performance_monitoring_app/models/hod/hod_details.dart';

class OfficialNotices extends StatelessWidget {
  const OfficialNotices({super.key});

  @override
  Widget build(BuildContext context) {
    final HodDetailsModel hod =
        ModalRoute.of(context)!.settings.arguments as HodDetailsModel;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.spaceCadet,
        automaticallyImplyLeading: true,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: AppColors.spaceCadet),
        title: Text(
          'Official Notices',
          style: GoogleFonts.getFont(
            'Outfit',
            color: AppColors.isabelline,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
        elevation: 2,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/hod/new_notice_page', arguments: hod);
        },
        label: Text(
          'New Notice',
          style: GoogleFonts.getFont('Outfit', fontSize: 15),
        ),
        icon: const Icon(Icons.add),
        backgroundColor: AppColors.spaceCadet, // Background color of the button
        foregroundColor: AppColors.isabelline,
      ),
      body: ShowNotices(
        hod: hod,
      ),
    );
  }
}
