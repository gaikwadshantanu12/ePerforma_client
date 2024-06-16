import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';

class StudentAcademicsPage extends StatelessWidget {
  const StudentAcademicsPage({super.key});

  Widget _semesterRow({required String semester}) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(semester,
            style: GoogleFonts.getFont('Readex Pro',
                textStyle: const TextStyle(fontSize: 16))),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
            child: SizedBox(
              height: 50,
              child: TextFormField(
                obscureText: false,
                decoration: InputDecoration(
                  hintText: '0.0',
                  hintStyle: GoogleFonts.getFont(
                    'Readex Pro',
                    textStyle: const TextStyle(
                      fontSize: 18,
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
                keyboardType: TextInputType.emailAddress,
                cursorColor: AppColors.secondaryText,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Text('/',
            style: GoogleFonts.getFont('Readex Pro',
                textStyle: const TextStyle(fontSize: 20))),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
            child: SizedBox(
              height: 50,
              child: TextFormField(
                obscureText: false,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: '10',
                  hintStyle: GoogleFonts.getFont(
                    'Readex Pro',
                    textStyle: const TextStyle(
                      fontSize: 18,
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
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                cursorColor: AppColors.secondaryText,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _currentData({required double height}) {
    return // Generated code for this Container Widget...
        Material(
      color: Colors.transparent,
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Container(
        width: double.infinity,
        height: height * 0.65,
        decoration: const BoxDecoration(
          color: AppColors.freshWhite,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Current Academics',
                  style: GoogleFonts.getFont('Readex Pro',
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600))),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: _semesterRow(semester: 'FE - Sem 1'),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: _semesterRow(semester: 'FE - Sem 2'),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: _semesterRow(semester: 'SE - Sem 3'),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: _semesterRow(semester: 'SE - Sem 4'),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: _semesterRow(semester: 'TE - Sem 5'),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: _semesterRow(semester: 'TE - Sem 6'),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: _semesterRow(semester: 'BE - Sem 7'),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: _semesterRow(semester: 'BE - Sem 8'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _singleRowDetails(
      {required double height,
      required String titleText,
      required String labelText}) {
    return Material(
      color: Colors.transparent,
      elevation: 2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Container(
        width: double.infinity,
        height: height * 0.15,
        decoration: const BoxDecoration(
          color: AppColors.freshWhite,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(titleText,
                  style: GoogleFonts.getFont('Readex Pro',
                      textStyle: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w600))),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(8, 10, 8, 0),
                child: TextFormField(
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: labelText,
                    labelStyle: GoogleFonts.getFont(
                      'Readex Pro',
                      textStyle: const TextStyle(
                        fontSize: 16,
                        color: AppColors.secondaryText,
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
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: AppColors.secondaryText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.spaceCadet,
        automaticallyImplyLeading: true,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: AppColors.spaceCadet),
        title: Text(
          'Student Academics',
          style: GoogleFonts.getFont(
            'Outfit',
            textStyle: const TextStyle(
              color: AppColors.isabelline,
              fontSize: 22,
            ),
          ),
        ),
        centerTitle: false,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                height: height * 0.02,
              ),
              _currentData(height: height),
              SizedBox(
                height: height * 0.02,
              ),
              _singleRowDetails(
                height: height,
                titleText: 'Diploma',
                labelText: 'Enter Diploma Result',
              ),
              SizedBox(
                height: height * 0.02,
              ),
              _singleRowDetails(
                height: height,
                titleText: '12th (HSC)',
                labelText: 'Enter 12th Result',
              ),
              SizedBox(
                height: height * 0.02,
              ),
              _singleRowDetails(
                height: height,
                titleText: '10th (SSC)',
                labelText: 'Enter 10th Result',
              ),
              SizedBox(
                height: height * 0.02,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
