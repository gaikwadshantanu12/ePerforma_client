import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:flip_card/flip_card.dart';
import 'package:student_performance_monitoring_app/constants/session_manager.dart';
import 'package:student_performance_monitoring_app/models/student/student_details.dart';
import 'package:http/http.dart' as http;

class StudentAuthenticationPage extends StatefulWidget {
  const StudentAuthenticationPage({super.key});

  @override
  State<StudentAuthenticationPage> createState() =>
      _StudentAuthenticationPageState();
}

class _StudentAuthenticationPageState extends State<StudentAuthenticationPage> {
  final _signUpFormKey = GlobalKey<FormState>();
  final _loginFormKey = GlobalKey<FormState>();

  final _emailLoginController = TextEditingController();
  final _passwordLoginController = TextEditingController();

  final _studentID = TextEditingController();
  final _studentFullName = TextEditingController();
  final _studentEmail = TextEditingController();
  final _studentPassword = TextEditingController();
  final _studentConfirmPassword = TextEditingController();

  String? _studentDepartment;

  late bool _registerPasswordVisible,
      _registerConfirmPasswordVisible,
      _loginPasswordShowHide;

  List<DropdownMenuItem<String>> get departmentNames {
    List<DropdownMenuItem<String>> dropDownItems = [
      const DropdownMenuItem(
        value: "Mechanical Engineering",
        child: Text("Mech. Engineering"),
      ),
      const DropdownMenuItem(
        value: "E&TC Engineering",
        child: Text("E&TC Engineering"),
      ),
      const DropdownMenuItem(
        value: "Civil Engineering",
        child: Text("Civil Engineering"),
      ),
      const DropdownMenuItem(
        value: "Computer Science & Engineering",
        child: Text("CSE Engineering"),
      ),
      const DropdownMenuItem(
        value: "AI&DS Engineering",
        child: Text("AI&DS Engineering"),
      ),
    ];

    return dropDownItems;
  }

  @override
  void initState() {
    super.initState();

    _registerPasswordVisible = false;
    _registerConfirmPasswordVisible = false;
    _loginPasswordShowHide = false;
  }

  @override
  void dispose() {
    _emailLoginController.dispose();
    _passwordLoginController.dispose();

    _studentID.dispose();
    _studentFullName.dispose();
    _studentEmail.dispose();
    _studentPassword.dispose();
    _studentConfirmPassword.dispose();
    super.dispose();
  }

  Future<void> registerNewStudent(StudentDetailsModel model) async {
    try {
      var url = "http://192.168.1.8:8080/student/addNewStudent";
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{"Content-Type": "application/json"},
        body: model.toJson(),
      );

      String responseText = response.body;

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Registration Status"),
            content: Text(responseText),
            actions: <Widget>[
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      print("Exception is $e");
    }
  }

  Future<void> _loginExistingStudent() async {
    try {
      var url =
          "http://192.168.1.8:8080/student/loginStudent/email=${_emailLoginController.text}&password=${_passwordLoginController.text}";
      var response = await http.get(
        Uri.parse(url),
        headers: <String, String>{"Content-Type": "application/json"},
      );

      if (response.statusCode == 200) {
        StudentDetailsModel model = StudentDetailsModel.fromJson(response.body);
        // ignore: avoid_print
        print(model);

        await SessionManager.setLoggedIn(true);

        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/student_dashboard_page');
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Login Status"),
              content: const Text(
                  "Student Not Found. Please check email and password."),
              actions: <Widget>[
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Exception is $e');
    }
  }

  Widget _pointsToRemember({required String hint}) {
    return Align(
      alignment: const AlignmentDirectional(-1, 0),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 10, 10, 0),
        child: Text(
          hint,
          style: GoogleFonts.getFont(
            'Open Sans',
            textStyle: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
    );
  }

  Widget _customSignupSignin(
      {required String buttonText,
      required Icon buttonIcon,
      required VoidCallback buttonClicked}) {
    return Align(
      alignment: const AlignmentDirectional(0, 0),
      child: ElevatedButton.icon(
        onPressed: buttonClicked,
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
          buttonText,
          style: GoogleFonts.getFont(
            'Readex Pro',
            textStyle: const TextStyle(color: AppColors.isabelline),
          ),
        ),
        icon: buttonIcon,
      ),
    );
  }

  Widget _loginSection(
      {required double deviceWidth, required double deviceHeight}) {
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
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 0, 8, 0),
                          child: TextFormField(
                            controller: _emailLoginController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Email ID',
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
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                return 'Enter a valid email!';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              8, 25, 8, 15),
                          child: TextFormField(
                            controller: _passwordLoginController,
                            obscureText: !_loginPasswordShowHide,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: GoogleFonts.getFont(
                                'Readex Pro',
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.secondaryText,
                                ),
                              ),
                              hintStyle: GoogleFonts.getFont('Readex Pro',
                                  textStyle: const TextStyle(fontSize: 16)),
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
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => _loginPasswordShowHide =
                                      !_loginPasswordShowHide,
                                ),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  _loginPasswordShowHide
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: AppColors.secondaryText,
                                  size: 25,
                                ),
                              ),
                            ),
                            style: GoogleFonts.getFont(
                              'Readex Pro',
                              textStyle: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            cursorColor: AppColors.secondaryText,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                          ),
                        ),
                        _customSignupSignin(
                          buttonText: "Login",
                          buttonIcon: const Icon(Icons.login),
                          buttonClicked: () async {
                            if (_loginFormKey.currentState!.validate()) {
                              await _loginExistingStudent();
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

  Widget _createAccountSection(
      {required double deviceWidth, required double deviceHeight}) {
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
            height: deviceHeight * 0.8,
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
                  child: Align(
                    alignment: const AlignmentDirectional(0, 0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              8, 10, 8, 10),
                          child: TextFormField(
                            controller: _studentID,
                            textCapitalization: TextCapitalization.none,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'ID Card UID',
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
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r"\d{8}[A-Z]{2}\d{3}")
                                      .hasMatch(value)) {
                                return 'Provide proper college ID';
                              }
                              return null;
                            },
                            minLines: 1,
                            cursorColor: AppColors.secondaryText,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 5, 8, 5),
                          child: TextFormField(
                            controller: _studentFullName,
                            textCapitalization: TextCapitalization.words,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Full Name',
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
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter full name !';
                              }
                              return null;
                            },
                            style: GoogleFonts.getFont(
                              'Readex Pro',
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                            minLines: 1,
                            cursorColor: AppColors.secondaryText,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 5, 8, 5),
                          child: TextFormField(
                            controller: _studentEmail,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Email ID',
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
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: AppColors.secondaryText,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                      .hasMatch(value)) {
                                return 'Enter a valid email !';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 5, 8, 5),
                          child: DropdownButtonFormField(
                            items: departmentNames,
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
                              labelText: 'Select Department',
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
                              const EdgeInsetsDirectional.fromSTEB(8, 5, 8, 5),
                          child: TextFormField(
                            controller: _studentPassword,
                            obscureText: !_registerPasswordVisible,
                            decoration: InputDecoration(
                              labelText: 'Password',
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
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => _registerPasswordVisible =
                                      !_registerPasswordVisible,
                                ),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  _registerPasswordVisible
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: AppColors.secondaryText,
                                  size: 25,
                                ),
                              ),
                            ),
                            style: GoogleFonts.getFont(
                              'Readex Pro',
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            cursorColor: AppColors.secondaryText,
                            validator: (value) {
                              if (value!.isEmpty ||
                                  !RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
                                      .hasMatch(value)) {
                                return 'Enter a proper password !';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(8, 5, 8, 5),
                          child: TextFormField(
                            controller: _studentConfirmPassword,
                            obscureText: !_registerConfirmPasswordVisible,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
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
                              suffixIcon: InkWell(
                                onTap: () => setState(
                                  () => _registerConfirmPasswordVisible =
                                      !_registerConfirmPasswordVisible,
                                ),
                                focusNode: FocusNode(skipTraversal: true),
                                child: Icon(
                                  _registerConfirmPasswordVisible
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: AppColors.secondaryText,
                                  size: 25,
                                ),
                              ),
                            ),
                            style: GoogleFonts.getFont(
                              'Readex Pro',
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            cursorColor: AppColors.secondaryText,
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
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                          child: _customSignupSignin(
                            buttonText: "Create Account",
                            buttonIcon: const Icon(Icons.add),
                            buttonClicked: () async {
                              if (_signUpFormKey.currentState!.validate()) {
                                _signUpFormKey.currentState!.save();

                                final newStudent = StudentDetailsModel(
                                    studentCollegeID: _studentID.text,
                                    studentName: _studentFullName.text,
                                    studentEmail: _studentEmail.text,
                                    studentPassword: _studentPassword.text,
                                    studentDepartment: _studentDepartment!);

                                await registerNewStudent(newStudent);
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentDeviceWidth = MediaQuery.sizeOf(context).width;
    final currentDeviceHeight = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.spaceCadet,
        automaticallyImplyLeading: true,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: AppColors.spaceCadet),
        title: Text(
          'Student Authentication',
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
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlipCard(
              fill: Fill.fillBack,
              direction: FlipDirection.HORIZONTAL,
              onFlip: () {
                _signUpFormKey.currentState!.reset();
                _loginFormKey.currentState!.reset();
              },
              speed: 400,
              front: _createAccountSection(
                deviceWidth: currentDeviceWidth,
                deviceHeight: currentDeviceHeight,
              ),
              back: _loginSection(
                deviceWidth: currentDeviceWidth,
                deviceHeight: currentDeviceHeight,
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-1, 0),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(10, 20, 0, 0),
                child: Text(
                  'Points to Remember :',
                  style: GoogleFonts.getFont(
                    'Readex Pro',
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.spaceCadet,
                    ),
                  ),
                ),
              ),
            ),
            _pointsToRemember(
                hint:
                    '1. Tap the container to swap between Login and Registration Screen'),
            _pointsToRemember(
                hint:
                    '2. ID Card UID present on ID Card generated by institute'),
            _pointsToRemember(
                hint: '3. Provide a valid and a proper email address (active)'),
            _pointsToRemember(
              hint:
                  '4. Password must be minimum 8 characters long. And must be a good combination of alphanumeric characters and symbols.',
            ),
          ],
        ),
      ),
    );
  }
}
