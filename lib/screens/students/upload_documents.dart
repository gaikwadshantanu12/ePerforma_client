import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/constants/static_data.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/accounts_button.dart';
import 'package:student_performance_monitoring_app/middleware/students/student_mw.dart';

class UploadDocuments extends StatefulWidget {
  const UploadDocuments({super.key});

  @override
  State<UploadDocuments> createState() => _UploadDocumentsState();
}

class _UploadDocumentsState extends State<UploadDocuments> {
  File? _selectedFile;
  String? _documentType;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: ['pdf'],
      allowMultiple: false,
      type: FileType.custom,
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      int fileSize = await file.length(); // Get file size in bytes

      if (fileSize <= 5 * 1024 * 1024) {
        setState(() {
          _selectedFile = File(result.files.single.path!);
        });
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'File size exceeds limit! File size must be less than 5MB.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final String studentCollegeID =
        ModalRoute.of(context)!.settings.arguments as String;
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.spaceCadet,
        automaticallyImplyLeading: true,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: AppColors.spaceCadet),
        title: Text(
          'Upload Documents',
          style: GoogleFonts.getFont(
            'Outfit',
            color: AppColors.isabelline,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
        top: true,
        bottom: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Select File Type',
                  style: GoogleFonts.getFont(
                    'Outfit',
                    color: AppColors.spaceCadet,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                DropdownButtonFormField(
                  items: StaticData.documentType,
                  value: _documentType,
                  onChanged: (String? value) {
                    setState(() {
                      _documentType = value!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return "Please select document type";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "Select Document Type",
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
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                InkWell(
                  onTap: () => _pickFile(),
                  child: Container(
                    width: width,
                    height: height * 0.3,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryBackground,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          _selectedFile == null
                              ? 'Tap to select file'
                              : _selectedFile!.path.split('/').last,
                          style: GoogleFonts.getFont(
                            'Outfit',
                            color: AppColors.spaceCadet,
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Icon(
                          Icons.upload_rounded,
                          color: AppColors.spaceCadet,
                          size: 35,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                AccountButton(
                    buttonText: "Upload Document",
                    buttonIcon: const Icon(Icons.upload_file),
                    buttonClicked: () {
                      if (_selectedFile == null) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'Please select any document file to upload.')));
                      } else if (_documentType == null) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                'Please select document type corresponding with file to upload.')));
                      } else {
                        StudentsMiddleWare.uploadDocument(studentCollegeID,
                            _documentType!, _selectedFile!, context);
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
