import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/constants/static_data.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/accounts_button.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/normal_text_field.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/password_text_field.dart';
import 'package:student_performance_monitoring_app/middleware/teachers/teacher_mw.dart';
import 'package:student_performance_monitoring_app/models/teacher/teacher_details.dart';

class TeacherCreateAccount extends StatefulWidget {
  const TeacherCreateAccount({super.key});

  @override
  State<TeacherCreateAccount> createState() => _TeacherCreateAccountState();
}

class _TeacherCreateAccountState extends State<TeacherCreateAccount> {
  final _signUpFormKey = GlobalKey<FormState>();
  final _teacherID = TextEditingController();
  final _teacherName = TextEditingController();
  final _teacherEmail = TextEditingController();
  final _teacherPassword = TextEditingController();
  final _teacherConfirmPassword = TextEditingController();

  String? _teacherDepartment;

  late bool _registerPasswordVisible, _registerConfirmPasswordVisible;

  @override
  void initState() {
    super.initState();
    _registerPasswordVisible = false;
    _registerConfirmPasswordVisible = false;
  }

  @override
  void dispose() {
    _teacherID.dispose();
    _teacherName.dispose();
    _teacherEmail.dispose();
    _teacherPassword.dispose();
    _teacherConfirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return SingleChildScrollView(
      child: Align(
        alignment: const AlignmentDirectional(0, 0),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(15, 15, 15, 15),
          child: Material(
            color: Colors.transparent,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              width: deviceWidth,
              height: deviceHeight * 0.9,
              decoration: BoxDecoration(
                color: AppColors.isabelline,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: const AlignmentDirectional(0, 0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: Text(
                        'Teacher Registration',
                        style: GoogleFonts.getFont(
                          'Readex Pro',
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: _signUpFormKey,
                    child: Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          NormalTextField(
                            controller: _teacherID,
                            onChanged: (value) {
                              _teacherID.text = value!;
                              _teacherID.selection = TextSelection.collapsed(
                                  offset: _teacherID.text.length);
                            },
                            labelText: 'ID Card UID',
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r"\d{8}[A-Z]{2}\d{3}")
                                      .hasMatch(value)) {
                                return 'Provide proper college ID';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.text,
                          ),
                          NormalTextField(
                            controller: _teacherName,
                            onChanged: (value) {
                              _teacherName.text = value!;
                              _teacherName.selection = TextSelection.collapsed(
                                  offset: _teacherName.text.length);
                            },
                            labelText: 'Full Name',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter full name !';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.name,
                          ),
                          NormalTextField(
                            controller: _teacherEmail,
                            onChanged: (value) {
                              _teacherEmail.text = value!;
                              _teacherEmail.selection = TextSelection.collapsed(
                                  offset: _teacherEmail.text.length);
                            },
                            labelText: 'Email ID',
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                return 'Enter a valid email !';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8, 10, 8, 10),
                            child: DropdownButtonFormField(
                              items: StaticData.departmentNames,
                              value: _teacherDepartment,
                              onChanged: (String? value) {
                                setState(() {
                                  _teacherDepartment = value!;
                                });
                              },
                              validator: (value) {
                                if (value == null) {
                                  return "Please select department";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: "Select department",
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
                          PasswordTextField(
                            contoller: _teacherPassword,
                            obscureText: !_registerPasswordVisible,
                            labelText: "Password",
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
                                      .hasMatch(value)) {
                                return 'Enter a proper password !';
                              }
                              return null;
                            },
                          ),
                          PasswordTextField(
                            contoller: _teacherConfirmPassword,
                            obscureText: !_registerConfirmPasswordVisible,
                            labelText: "Confirm Password",
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
                                      .hasMatch(value)) {
                                return 'Enter a proper password !';
                              } else if (value != _teacherPassword.text) {
                                return "Password & Confirm Password Not Matched";
                              }
                              return null;
                            },
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 10, 0, 0),
                            child: AccountButton(
                              buttonText: "Create Account",
                              buttonIcon: const Icon(Icons.add),
                              buttonClicked: () async {
                                if (_signUpFormKey.currentState!.validate()) {
                                  _signUpFormKey.currentState!.save();

                                  final newTeacher = TeacherDetailsModel(
                                      teacherCollegeID: _teacherID.text.trim(),
                                      teacherName: _teacherName.text.trim(),
                                      teacherEmail: _teacherEmail.text.trim(),
                                      teacherPassword:
                                          _teacherPassword.text.trim(),
                                      teacherDepartment: _teacherDepartment!);

                                  await TeachersMiddleWare.registerNewTeacher(
                                      newTeacher, context);
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
