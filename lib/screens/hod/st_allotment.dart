import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/constants/static_data.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/accounts_button.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/normal_text_field.dart';
import 'package:student_performance_monitoring_app/middleware/hod/hod_mw.dart';
import 'package:student_performance_monitoring_app/models/subject/subject_details.dart';
import 'package:student_performance_monitoring_app/models/teacher/teacher_details.dart';

class STAllotmentPage extends StatefulWidget {
  const STAllotmentPage({super.key});

  @override
  State<STAllotmentPage> createState() => _STAllotmentState();
}

class _STAllotmentState extends State<STAllotmentPage> {
  int _selectedSemester = 0;
  int _selectedYear = 0;
  final _subjectNameController = TextEditingController();
  final _subjectCodeController = TextEditingController();
  late String _department;
  List<TeacherDetailsModel> teachers = [];
  TeacherDetailsModel? _teacher;
  final _formKey = GlobalKey<FormState>();
  String? _studentCurrentSection;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _department = ModalRoute.of(context)?.settings.arguments as String? ?? '';
    _fetchTeacherData();
  }

  void _fetchTeacherData() {
    HodMiddleWare.fetchTeacherData(_department).then((teahcersList) {
      setState(() {
        teachers = teahcersList;
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
          'ST Allotment',
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Select Year',
                        style: GoogleFonts.getFont(
                          'Readex Pro',
                          textStyle: const TextStyle(
                            color: AppColors.spaceCadet,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Wrap(
                      spacing: 8.0, // Space between chips
                      children: List<Widget>.generate(4, (int index) {
                        return ChoiceChip(
                          label: Text(
                            switch (index) {
                              0 => 'FE',
                              1 => 'SE',
                              2 => 'TE',
                              3 => 'BE',
                              _ => 'FE',
                            },
                          ),
                          selected: _selectedYear == index,
                          onSelected: (bool selected) {
                            setState(() {
                              _selectedYear = selected
                                  ? index
                                  : (_selectedYear == -1
                                      ? 0
                                      : -1); // -1 for no selection
                            });
                          },
                          selectedColor: AppColors.silverPink,
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        'Select Semester',
                        style: GoogleFonts.getFont(
                          'Readex Pro',
                          textStyle: const TextStyle(
                            color: AppColors.spaceCadet,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Wrap(
                      spacing: 8.0, // Space between chips
                      children: List<Widget>.generate(8, (int index) {
                        return ChoiceChip(
                          label: Text('Sem ${index + 1}'),
                          selected: _selectedSemester == index,
                          onSelected: (bool selected) {
                            setState(() {
                              _selectedSemester = selected
                                  ? index
                                  : (_selectedSemester == -1
                                      ? 0
                                      : -1); // -1 for no selection
                            });
                          },
                          selectedColor: AppColors.silverPink,
                        );
                      }).toList(),
                    ),
                    NormalTextField(
                      controller: _subjectNameController,
                      onChanged: (value) {
                        _subjectNameController.text = value!;
                        _subjectNameController.selection =
                            TextSelection.collapsed(
                                offset: _subjectNameController.text.length);
                      },
                      labelText: 'Enter Subject Name',
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Enter a valid subject name !';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                    NormalTextField(
                      controller: _subjectCodeController,
                      onChanged: (value) {
                        _subjectCodeController.text = value!;
                        _subjectCodeController.selection =
                            TextSelection.collapsed(
                                offset: _subjectCodeController.text.length);
                      },
                      labelText: 'Enter Subject Code',
                      validator: (value) {
                        if (value!.trim().isEmpty) {
                          return 'Enter a valid subject code !';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(8, 10, 8, 10),
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
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(8, 10, 8, 10),
                      child: DropdownButtonFormField(
                        items: StaticData.sections,
                        value: _studentCurrentSection,
                        onChanged: (String? value) {
                          setState(() {
                            _studentCurrentSection = value!;
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
                    AccountButton(
                      buttonText: "Generate Subject & Allot Subject Teacher",
                      buttonIcon: const Icon(Icons.generating_tokens),
                      buttonClicked: () async {
                        if (_formKey.currentState!.validate()) {
                          if (_selectedSemester == -1 || _selectedYear == -1) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text(
                                    "Please select the year and semester"),
                                duration: const Duration(seconds: 2),
                                action: SnackBarAction(
                                  label: 'Okay',
                                  onPressed: () {},
                                ),
                              ),
                            );
                          } else {
                            final result = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Confirmation'),
                                content: Text(
                                    "Are you sure you want to generate this subject for the given semester and assign the subject teacher with the below details ? \n\nSemester - Semester ${_selectedSemester + 1}\nSubject Name - ${_subjectNameController.text}\nSubject Code - ${_subjectCodeController.text}\nSubject Teacher - ${_teacher!.teacherName}\n\nIf you're sure then click ok."),
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
                              final model = SubjectDetails(
                                subjectName: _subjectNameController.text,
                                subjectCode: _subjectCodeController.text,
                                teacherName: _teacher!.teacherName,
                                teacherID: _teacher!.teacherCollegeID,
                                department: _department,
                                semester: (_selectedSemester + 1).toString(),
                                year: switch (_selectedYear) {
                                  0 => 'FE',
                                  1 => 'SE',
                                  2 => 'TE',
                                  3 => 'BE',
                                  _ => 'FE'
                                },
                                section: _studentCurrentSection!,
                              );

                              // ignore: use_build_context_synchronously
                              await HodMiddleWare.generateSubject(
                                  model, context);
                            }
                          }
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          )),
    );
  }
}
