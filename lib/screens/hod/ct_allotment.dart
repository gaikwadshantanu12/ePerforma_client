import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/constants/static_data.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/accounts_button.dart';
import 'package:student_performance_monitoring_app/middleware/hod/hod_mw.dart';
import 'package:student_performance_monitoring_app/models/class/class_details.dart';
import 'package:student_performance_monitoring_app/models/teacher/teacher_details.dart';

class CTAllotmentPage extends StatefulWidget {
  const CTAllotmentPage({super.key});

  @override
  State<CTAllotmentPage> createState() => _CTAllotmentPageState();
}

class _CTAllotmentPageState extends State<CTAllotmentPage> {
  String? _year;
  String? _section;
  TeacherDetailsModel? _teacher;
  late String _department;
  List<TeacherDetailsModel> teachers = [];
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _department = ModalRoute.of(context)?.settings.arguments as String? ?? '';
    _fetchTeacherData();
  }

  void _fetchTeacherData() {
    HodMiddleWare.fetchTeacherData(_department).then((teachersList) {
      setState(() {
        teachers = teachersList;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.spaceCadet,
        automaticallyImplyLeading: true,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: AppColors.spaceCadet),
        title: Text(
          'CT Allotment',
          style: GoogleFonts.getFont(
            'Outfit',
            color: AppColors.isabelline,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 10, 8, 10),
                    child: DropdownButtonFormField(
                      items: StaticData.academicYears,
                      value: _year,
                      onChanged: (String? value) {
                        setState(() {
                          _year = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Please select year";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Select Year",
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
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 10, 8, 10),
                    child: DropdownButtonFormField(
                      items: StaticData.sections,
                      value: _section,
                      onChanged: (String? value) {
                        setState(() {
                          _section = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Please select section";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Select Section",
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
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(8, 10, 8, 10),
                    child: DropdownButtonFormField<TeacherDetailsModel>(
                      items: teachers.map((TeacherDetailsModel teacher) {
                        return DropdownMenuItem<TeacherDetailsModel>(
                          value: teacher,
                          child: Text(teacher.teacherName),
                        );
                      }).toList(),
                      value: _teacher,
                      onChanged: (TeacherDetailsModel? value) {
                        setState(() {
                          _teacher = value!;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return "Please select teacher";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: "Select Teacher",
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
                  ),
                  AccountButton(
                    buttonText: "Generate Class & Allot Teacher",
                    buttonIcon: const Icon(Icons.generating_tokens),
                    buttonClicked: () async {
                      if (_formKey.currentState!.validate()) {
                        final result = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Confirmation'),
                            content: Text(
                                "Are you sure you want to generate this class with the below details ? \n\nYear - $_year\nSection - $_section\nClass Teacher - ${_teacher!.teacherName}\n\nIf you're sure then click ok."),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, false), // Cancel
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, true), // Confirm
                                child: const Text('Yes'),
                              ),
                            ],
                          ),
                        );

                        if (result ?? false) {
                          final model = ClassDetails(
                              year: _year!,
                              section: _section!,
                              department: _department,
                              teacherName: _teacher!.teacherName,
                              teacherID: _teacher!.teacherCollegeID);

                          // ignore: use_build_context_synchronously
                          await HodMiddleWare.generateClassAndCT(
                              model, context);
                        }
                      }
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
