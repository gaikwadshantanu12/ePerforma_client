import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/normal_text_field.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/password_text_field.dart';
import 'package:student_performance_monitoring_app/middleware/hod/hod_mw.dart';

class HodAuthenticationPage extends StatefulWidget {
  const HodAuthenticationPage({super.key});

  @override
  State<HodAuthenticationPage> createState() => _HodAuthenticationPageState();
}

class _HodAuthenticationPageState extends State<HodAuthenticationPage> {
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

  Widget _loginButton() {
    return Align(
      alignment: const AlignmentDirectional(0, 0),
      child: ElevatedButton.icon(
        onPressed: () async {
          if (_loginFormKey.currentState!.validate()) {
            HodMiddleWare.loginExistingHod(_emailLoginController.text.trim(),
                _passwordLoginController.text.trim(), context);
          }
        },
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsetsDirectional.fromSTEB(24, 10, 24, 10),
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
          "Log Me In !",
          style: GoogleFonts.getFont(
            'Readex Pro',
            textStyle: const TextStyle(color: AppColors.isabelline),
          ),
        ),
        icon: const Icon(Icons.login),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.spaceCadet,
        automaticallyImplyLeading: true,
        title: Text(
          'HOD\'s Authentication',
          style: GoogleFonts.getFont(
            'Outfit',
            textStyle: const TextStyle(
              color: AppColors.isabelline,
              fontSize: 22,
            ),
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: SafeArea(
        top: true,
        child: Center(
          child: Card(
            margin: const EdgeInsets.all(20),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            color: AppColors.silverPink,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: const BoxDecoration(
                color: AppColors.isabelline,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    'Head of Department\nLogin',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.getFont(
                      'Readex Pro',
                      textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
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
                                      offset:
                                          _emailLoginController.text.length);
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
                          ),
                          PasswordTextField(
                            contoller: _passwordLoginController,
                            obscureText: !_loginPasswordShowHide,
                            labelText: "Password",
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                          ),
                          _loginButton()
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
