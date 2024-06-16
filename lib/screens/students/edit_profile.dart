import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_performance_monitoring_app/constants/api.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/constants/static_data.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/accounts_button.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/normal_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:student_performance_monitoring_app/middleware/students/student_mw.dart';
import 'package:path/path.dart' as path;

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  bool _isStudentDataLoaded = false;
  final _studentFullName = TextEditingController();
  final _studentPersonalEmail = TextEditingController();
  final _studentCollegeEmail = TextEditingController();
  final _studentMobileNumber = TextEditingController();
  final _studentRollNumber = TextEditingController();
  String? _studentCurrentYear;
  String? _studentCurrentSection;
  late String _studentCollegeID;
  Uint8List? _image;
  File? selectedImage;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _studentCollegeID =
        ModalRoute.of(context)?.settings.arguments as String? ?? '';
    if (!_isStudentDataLoaded) {
      _fetchStudentData();
      _isStudentDataLoaded = true;
    }
  }

  void _fetchStudentData() {
    StudentsMiddleWare.fetchParticularStudentData(_studentCollegeID)
        .then((student) {
      _studentFullName.text = student.studentName;

      _studentPersonalEmail.text = student.studentPersonalEmail == ''
          ? 'NA'
          : student.studentPersonalEmail;
      _studentCollegeEmail.text = student.studentCollegeEmail == ''
          ? 'NA'
          : student.studentCollegeEmail;
      _studentMobileNumber.text =
          student.studentMobile == '' ? 'NA' : student.studentMobile;
      _studentRollNumber.text = student.studentRollNo.toString() == ''
          ? 'NA'
          : student.studentRollNo.toString();
      setState(() {
        _studentCurrentYear = student.studentCurrentYear;
        _studentCurrentSection = student.studentCurrentSection;
      });
    });
  }

  Future _pickImageFromGallery() async {
    final returnImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnImage != null) {
      final fileSizeInBytes = File(returnImage.path).lengthSync();
      final fileSizeInMB = fileSizeInBytes / (1024 * 1024);

      if (fileSizeInMB > 5) {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text("Image Size Error"),
            content: const Text(
                "The selected image exceeds the size limit. Please select image below 5MB size."),
            actions: [
              TextButton(
                child: const Text("Okay"),
                onPressed: () => Navigator.of(ctx).pop(),
              )
            ],
          ),
        );
      } else {
        setState(() {
          selectedImage = File(returnImage.path);
          _image = File(returnImage.path).readAsBytesSync();
        });
      }
    }
  }

  Future<void> _updateProfile() async {
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiRoutes.updateStudent));

    request.fields['studentName'] = _studentFullName.text.trim();
    request.fields['studentPersonalEmail'] = _studentPersonalEmail.text.trim();
    request.fields['studentCollegeEmail'] = _studentCollegeEmail.text.trim();
    request.fields['studentMobile'] = _studentMobileNumber.text.trim();
    request.fields['studentRollNo'] = _studentRollNumber.text.trim();
    request.fields['studentID'] = _studentCollegeID;
    request.fields['studentCurrentYear'] = _studentCurrentYear!;
    request.fields['studentCurrentSection'] = _studentCurrentSection!;

    request.files.add(http.MultipartFile.fromBytes(
        'profilePhoto', selectedImage!.readAsBytesSync(),
        filename: path.basename(selectedImage!.path)));

    var response = await request.send();
    if (response.statusCode == 200) {
      _formKey.currentState?.reset();

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile Updated Successfully!')));
      _fetchStudentData();
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Profile Not Update !')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.spaceCadet,
        automaticallyImplyLeading: true,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: AppColors.spaceCadet),
        title: Text(
          'Update Profile',
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
          child: Align(
            alignment: const AlignmentDirectional(0, 0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      width: deviceWidth * 0.5,
                      height: deviceHeight * 0.23,
                      margin: const EdgeInsets.only(top: 20),
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: _image != null
                          ? Image.memory(
                              _image!,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=900&q=60',
                              fit: BoxFit.cover,
                            ),
                    ),
                    // Pencil Icon
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0, 18, 8, 0),
                      child: Container(
                        width: deviceWidth * 0.12,
                        height: deviceHeight * 0.06,
                        decoration: BoxDecoration(
                          color: AppColors.primaryBackground,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.secondaryText,
                            width: 4,
                          ),
                        ),
                        child: IconButton(
                          onPressed: () {
                            _pickImageFromGallery();
                          },
                          icon: const Icon(Icons.edit, size: 20),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                          controller: _studentPersonalEmail,
                          onChanged: (value) {
                            _studentPersonalEmail.text = value!;
                            _studentPersonalEmail.selection =
                                TextSelection.collapsed(
                                    offset: _studentPersonalEmail.text.length);
                          },
                          labelText: 'Personal Email ID',
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
                          controller: _studentCollegeEmail,
                          onChanged: (value) {
                            _studentCollegeEmail.text = value!;
                            _studentCollegeEmail.selection =
                                TextSelection.collapsed(
                                    offset: _studentCollegeEmail.text.length);
                          },
                          labelText: 'College Email ID',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: deviceWidth * 0.6,
                              child: NormalTextField(
                                controller: _studentMobileNumber,
                                onChanged: (value) {
                                  _studentMobileNumber.text = value!;
                                  _studentMobileNumber.selection =
                                      TextSelection.collapsed(
                                          offset:
                                              _studentMobileNumber.text.length);
                                },
                                labelText: 'Mobile Number',
                                keyboardType: TextInputType.phone,
                                validator: (value) {
                                  if (value!.isEmpty ||
                                      !RegExp(r'^[0-9]{10}$').hasMatch(value)) {
                                    return 'Enter a valid mobile number !';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(
                              width:
                                  deviceWidth * 0.3, // Adjust width as needed
                              child: NormalTextField(
                                controller: _studentRollNumber,
                                onChanged: (value) {
                                  setState(() {
                                    _studentRollNumber.text = value!;
                                    _studentRollNumber.selection =
                                        TextSelection.collapsed(
                                            offset:
                                                _studentRollNumber.text.length);
                                  });
                                },
                                labelText: 'Roll Number',
                                keyboardType:
                                    TextInputType.number, // For numbers
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter a valid roll no !';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
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
                        SizedBox(
                          height: deviceHeight * 0.2,
                          child: AccountButton(
                            buttonText: 'Update Profile',
                            buttonIcon: const Icon(Icons.update_outlined),
                            buttonClicked: () {
                              if (_formKey.currentState!.validate()) {
                                if (selectedImage == null ||
                                    _studentCollegeEmail.text == 'NA' ||
                                    _studentRollNumber.text == '0') {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Please Enter All Fields & Select Profile Photo Too !'),
                                    ),
                                  );
                                } else {
                                  _updateProfile();
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
