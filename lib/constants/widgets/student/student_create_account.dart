import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/constants/static_data.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/accounts_button.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/normal_text_field.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/password_text_field.dart';
import 'package:student_performance_monitoring_app/middleware/students/student_mw.dart';
import 'package:student_performance_monitoring_app/models/student/student_details.dart';

class StudentCreateAccount extends StatefulWidget {
  const StudentCreateAccount({super.key});

  @override
  State<StudentCreateAccount> createState() => _StudentCreateAccountState();
}

class _StudentCreateAccountState extends State<StudentCreateAccount> {
  final _signUpFormKey = GlobalKey<FormState>();
  final _studentID = TextEditingController();
  final _studentFullName = TextEditingController();
  final _studentEmail = TextEditingController();
  final _studentPassword = TextEditingController();
  final _studentConfirmPassword = TextEditingController();
  final _studentMobileNumber = TextEditingController();
  String? _studentDepartment;
  String? _studentCurrentYear;
  String? _studentCurrentSection;
  late bool _registerPasswordVisible, _registerConfirmPasswordVisible;

  @override
  void initState() {
    super.initState();
    _registerPasswordVisible = false;
    _registerConfirmPasswordVisible = false;
  }

  @override
  void dispose() {
    _studentID.dispose();
    _studentFullName.dispose();
    _studentEmail.dispose();
    _studentPassword.dispose();
    _studentConfirmPassword.dispose();

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
          padding: const EdgeInsetsDirectional.fromSTEB(15, 10, 15, 10),
          child: Material(
            color: Colors.transparent,
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              width: deviceWidth,
              height: deviceHeight * 1.3,
              decoration: BoxDecoration(
                color: AppColors.isabelline,
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: const AlignmentDirectional(0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: const AlignmentDirectional(0, 0),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      child: Text(
                        'Student Registration',
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NormalTextField(
                          controller: _studentID,
                          onChanged: (value) {
                            _studentID.text = value!;
                            _studentID.selection = TextSelection.collapsed(
                                offset: _studentID.text.length);
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
                          controller: _studentFullName,
                          onChanged: (value) {
                            _studentFullName.text = value!;
                            _studentFullName.selection =
                                TextSelection.collapsed(
                                    offset: _studentFullName.text.length);
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
                          controller: _studentEmail,
                          onChanged: (value) {
                            _studentEmail.text = value!;
                            _studentEmail.selection = TextSelection.collapsed(
                                offset: _studentEmail.text.length);
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
                        NormalTextField(
                          controller: _studentMobileNumber,
                          onChanged: (value) {
                            _studentMobileNumber.text = value!;
                            _studentMobileNumber.selection =
                                TextSelection.collapsed(
                                    offset: _studentMobileNumber.text.length);
                          },
                          labelText: 'Mobile Number',
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                              return 'Enter a valid mobile number !';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.phone,
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              8, 10, 8, 10),
                          child: DropdownButtonFormField(
                            items: StaticData.departmentNames,
                            value: _studentDepartment,
                            onChanged: (String? value) {
                              setState(() {
                                _studentDepartment = value!;
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
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              8, 10, 8, 10),
                          child: DropdownButtonFormField(
                            items: StaticData.academicYears,
                            value: _studentCurrentYear,
                            onChanged: (String? value) {
                              setState(() {
                                _studentCurrentYear = value!;
                              });
                            },
                            validator: (value) {
                              if (value == null) {
                                return "Please select academic year";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: "Select Academic Year",
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
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              8, 10, 8, 10),
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
                        PasswordTextField(
                          contoller: _studentPassword,
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
                          contoller: _studentConfirmPassword,
                          obscureText: !_registerConfirmPasswordVisible,
                          labelText: "Confirm Password",
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
                                    .hasMatch(value)) {
                              return 'Enter a proper password !';
                            } else if (value != _studentPassword.text) {
                              return "Password & Confirm Password Not Matched";
                            }
                            return null;
                          },
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: AccountButton(
                            buttonText: "Create Account",
                            buttonIcon: const Icon(Icons.add),
                            buttonClicked: () async {
                              if (_signUpFormKey.currentState != null &&
                                  _signUpFormKey.currentState!.validate()) {
                                _signUpFormKey.currentState!.save();

                                final newStudent = StudentDetailsModel(
                                  studentCollegeID: _studentID.text.trim(),
                                  studentName: _studentFullName.text.trim(),
                                  studentPersonalEmail:
                                      _studentEmail.text.trim(),
                                  studentMobile:
                                      _studentMobileNumber.text.trim(),
                                  studentPassword: _studentPassword.text.trim(),
                                  studentDepartment: _studentDepartment!,
                                  studentCurrentYear: _studentCurrentYear!,
                                  studentRollNo: 0,
                                  studentProfilePhoto: '',
                                  studentCollegeEmail: '',
                                  studentCurrentSection:
                                      _studentCurrentSection!,
                                );

                                await StudentsMiddleWare.registerNewStudent(
                                    newStudent, context);
                              }
                            },
                          ),
                        )
                      ],
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
