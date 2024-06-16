import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/api.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/default_animation.dart';
import 'package:student_performance_monitoring_app/constants/widgets/hod/show_pdf.dart';
import 'package:student_performance_monitoring_app/middleware/students/student_mw.dart';
import 'package:student_performance_monitoring_app/models/notices/notices_details.dart';
import 'package:http/http.dart' as http;

class ViewNotices extends StatefulWidget {
  const ViewNotices({super.key});

  @override
  State<ViewNotices> createState() => _ViewNoticesState();
}

class _ViewNoticesState extends State<ViewNotices> {
  late String _studentDepartment;
  List<NoticesDetailsModel> _notices = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _studentDepartment =
        ModalRoute.of(context)?.settings.arguments as String? ?? '';
    isLoading = true;
    _fetchData();
  }

  void _fetchData() {
    StudentsMiddleWare.fetchNoticesByDepartment(_studentDepartment)
        .then((noticesList) {
      setState(() {
        _notices = noticesList;
        isLoading = false;
      });
    });
  }

  double _calculateTextHeight(String text, TextStyle style, double maxWidth) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 10, // Set a reasonable max limit
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    return textPainter.height * 1.3;
  }

  void _downloadAndDisplayFile(String hodID, String fileName) async {
    try {
      final url = '${ApiRoutes.downloadFile}/hod_id=$hodID&filename=$fileName';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ShowPDF(pdfBytes: response.bodyBytes, fileName: fileName),
          ),
        );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.sizeOf(context).width;
    final deviceHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.spaceCadet,
        automaticallyImplyLeading: true,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: AppColors.spaceCadet),
        title: Text(
          'View Notices',
          style: GoogleFonts.getFont(
            'Outfit',
            color: AppColors.isabelline,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
        elevation: 2,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : _notices.isEmpty
              ? DefaultAnimationMessage(
                  animationFile: "assets/lottie_animations/no_data_found.json",
                  animationMessage:
                      "Oopps !!! No notices sent found for students of $_studentDepartment. ",
                  deviceWidth: deviceWidth,
                  deviceHeight: deviceHeight,
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: _notices.length,
                  itemBuilder: (context, index) {
                    final textStyle = GoogleFonts.getFont(
                      'Readex Pro',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      textStyle:
                          const TextStyle(color: AppColors.heliotropeGray),
                    );

                    final requiredHeight = _calculateTextHeight(
                        _notices[index].noticeMessage,
                        textStyle,
                        deviceWidth * 0.7);

                    return GestureDetector(
                      onTap: () {
                        _downloadAndDisplayFile(_notices[index].hodCollegeID,
                            _notices[index].noticeFileName);
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        width: deviceWidth,
                        height: requiredHeight + 80,
                        decoration: BoxDecoration(
                            color: AppColors.isabelline,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _notices[index].noticeTitle,
                                style: GoogleFonts.getFont(
                                  'Readex Pro',
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                _notices[index].noticeMessage,
                                textAlign: TextAlign.justify,
                                style: GoogleFonts.getFont(
                                  'Readex Pro',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  textStyle: const TextStyle(
                                      color: AppColors.heliotropeGray),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
