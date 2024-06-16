import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/accounts_button.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/normal_text_field.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/password_text_field.dart';
import 'package:student_performance_monitoring_app/middleware/students/student_mw.dart';

class StudentLogin extends StatefulWidget {
  const StudentLogin({super.key});

  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  final _loginFormKey = GlobalKey<FormState>();

  final _emailLoginController = TextEditingController();
  final _passwordLoginController = TextEditingController();

  late bool _loginPasswordShowHide;

  @override
  void initState() {
    super.initState();
    _loginPasswordShowHide = false;
  }

  @override
  void dispose() {
    _emailLoginController.dispose();
    _passwordLoginController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Align(
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
            width: deviceWidth * 0.9,
            height: deviceHeight * 0.4,
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
                  child: Text(
                    'Student Login',
                    style: GoogleFonts.getFont(
                      'Readex Pro',
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Form(
                  key: _loginFormKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: Align(
                    alignment: const AlignmentDirectional(0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        NormalTextField(
                          controller: _emailLoginController,
                          onChanged: (value) {
                            _emailLoginController.text = value!;
                            _emailLoginController.selection =
                                TextSelection.collapsed(
                                    offset: _emailLoginController.text.length);
                          },
                          labelText: "Email ID",
                          validator: (value) {
                            if (value!.isEmpty ||
                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value)) {
                              return 'Enter a valid email!';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                        ),
                        PasswordTextField(
                          contoller: _passwordLoginController,
                          obscureText: _loginPasswordShowHide,
                          labelText: "Password",
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                        ),
                        AccountButton(
                          buttonText: "Login",
                          buttonIcon: const Icon(Icons.login),
                          buttonClicked: () async {
                            if (_loginFormKey.currentState!.validate()) {
                              await StudentsMiddleWare.loginExistingStudent(
                                  _emailLoginController.text.trim(),
                                  _passwordLoginController.text.trim(),
                                  context);
                            }
                          },
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
    );
  }
}
