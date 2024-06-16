import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/default_animation.dart';
import 'package:student_performance_monitoring_app/middleware/hod/hod_mw.dart';
import 'package:student_performance_monitoring_app/models/hod/hod_details.dart';
import 'package:student_performance_monitoring_app/models/notices/notices_details.dart';

// ignore: must_be_immutable
class ShowNotices extends StatefulWidget {
  HodDetailsModel hod;

  ShowNotices({
    Key? key,
    required this.hod,
  }) : super(key: key);

  @override
  State<ShowNotices> createState() => _ShowNoticesState();
}

class _ShowNoticesState extends State<ShowNotices> {
  List<NoticesDetailsModel> _notices = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    _fetchData();
  }

  void _fetchData() {
    Future.delayed(const Duration(seconds: 2), () {
      HodMiddleWare.fetchAllNotices(widget.hod.hodCollegeID).then((notices) {
        setState(() {
          _notices = notices;
          isLoading = false;
        });
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

  void _deleteNotice(int index, int noticeID) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this notice?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // _deleteNoticeDB(noticeID);
              HodMiddleWare.deleteNoticeDB(noticeID, context);
              setState(() {
                _notices.removeAt(index);
                Navigator.of(context).pop(); // Close the dialog
              });
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.sizeOf(context).width;
    final deviceHeight = MediaQuery.sizeOf(context).height;

    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : _notices.isEmpty
            ? DefaultAnimationMessage(
                animationFile: "assets/lottie_animations/no_data_found.json",
                animationMessage:
                    "Oopps !!! No notices sent by ${widget.hod.hodName} (HOD) found. ",
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
                    textStyle: const TextStyle(color: AppColors.heliotropeGray),
                  );

                  final requiredHeight = _calculateTextHeight(
                      _notices[index].noticeMessage,
                      textStyle,
                      deviceWidth * 0.7);
                  return Slidable(
                    key: ValueKey(_notices[index]),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {},
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: 'Edit',
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            bottomLeft: Radius.circular(20),
                          ),
                        ),
                        SlidableAction(
                          onPressed: (context) {
                            _deleteNotice(index, _notices[index].noticeID);
                          },
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                        ),
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        // _downloadAndDisplayFile(_notices[index].noticeFileName);
                        HodMiddleWare.downloadAndDisplayFile(
                            widget.hod.hodCollegeID,
                            _notices[index].noticeFileName,
                            context);
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
                    ),
                  );
                },
              );
  }
}
