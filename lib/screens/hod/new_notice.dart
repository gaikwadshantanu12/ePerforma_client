import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/middleware/hod/hod_mw.dart';
import 'package:student_performance_monitoring_app/models/hod/hod_details.dart';

class NewNoticePage extends StatefulWidget {
  const NewNoticePage({super.key});

  @override
  State<NewNoticePage> createState() => _NewNoticePageState();
}

class _NewNoticePageState extends State<NewNoticePage> {
  final _noticeFormKey = GlobalKey<FormState>();
  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  final _noticeTitle = TextEditingController();
  final _noticeMessage = TextEditingController();
  String _fileName = 'No file selected';
  File? _selectedFile;

  Widget _noticeTitleAndMessage(
      {required int maxLines,
      required String labelText,
      required TextEditingController controller,
      required String? Function(String?) validator}) {
    return TextFormField(
      controller: controller,
      obscureText: false,
      decoration: InputDecoration(
        labelText: labelText,
        alignLabelWithHint: true,
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
            color: AppColors.secondaryText,
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
      textAlign: TextAlign.justify,
      maxLines: maxLines,
      validator: validator,
    );
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['pdf'],
      allowMultiple: false,
      type: FileType.custom,
    );

    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _fileName = _selectedFile!.path.split('/').last;
      });
    }
  }

  void sendNotice(String hodID, String hodDepartment) {
    HodMiddleWare.sendNewNotice(hodID, hodDepartment, _noticeTitle.text.trim(),
            _noticeMessage.text.trim(), _selectedFile, _fileName)
        .then((response) {
      if (response.statusCode == 200) {
        _noticeFormKey.currentState?.reset();
        _noticeTitle.clear();
        _noticeMessage.clear();
        _selectedFile = null;
        _fileName = 'No Selected File';
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Notice Sent Successfully!')));
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Notice Not Sent !')));
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _noticeTitle.dispose();
    _noticeMessage.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HodDetailsModel hod =
        ModalRoute.of(context)!.settings.arguments as HodDetailsModel;
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.spaceCadet,
        automaticallyImplyLeading: true,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: AppColors.spaceCadet),
        title: Text(
          'New Notice',
          style: GoogleFonts.getFont(
            'Outfit',
            color: AppColors.isabelline,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
          child: Form(
              key: _noticeFormKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: deviceHeight * 0.05,
                  ),
                  _noticeTitleAndMessage(
                    labelText: 'Title',
                    maxLines: 1,
                    controller: _noticeTitle,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a proper notice title.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: deviceHeight * 0.05,
                  ),
                  _noticeTitleAndMessage(
                    labelText: 'Message',
                    maxLines: 10,
                    controller: _noticeMessage,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter a proper notice message.';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: deviceHeight * 0.05,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.file_upload_rounded,
                          size: 30,
                          color: AppColors.independence,
                        ),
                        onPressed: _pickFile,
                      ),
                      SizedBox(
                        width: deviceWidth / 2,
                        child: Text(
                          _fileName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: GoogleFonts.getFont(
                            'Outfit',
                            color: AppColors.independence,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: deviceHeight * 0.05,
                  ),
                  ElevatedButton.icon(
                    onPressed: () async {
                      if (_noticeFormKey.currentState!.validate() &&
                          _selectedFile != null) {
                        sendNotice(hod.hodCollegeID, hod.hodDepartment);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Please Enter All Fields & Select File'),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            24, 10, 24, 10),
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
                      'Publish',
                      style: GoogleFonts.getFont(
                        'Readex Pro',
                        textStyle: const TextStyle(color: AppColors.isabelline),
                      ),
                    ),
                    icon: const Icon(Icons.send),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.05,
                  ),
                  Text(
                    'Note : \nFollowing notice(s) will be forwarded to student as well as teacher',
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.getFont(
                      'Readex Pro',
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
