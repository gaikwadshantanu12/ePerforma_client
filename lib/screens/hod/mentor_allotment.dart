import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/accounts_button.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/normal_text_field.dart';
import 'package:student_performance_monitoring_app/middleware/hod/hod_mw.dart';
import 'package:student_performance_monitoring_app/models/batches/batch_detail.dart';
import 'package:student_performance_monitoring_app/models/teacher/teacher_details.dart';

class MentorAllotment extends StatefulWidget {
  const MentorAllotment({super.key});

  @override
  State<MentorAllotment> createState() => _MentorAllotmentState();
}

class _MentorAllotmentState extends State<MentorAllotment> {
  int _selectedYear = 0;
  int _selectedSection = 0;
  int _selectedSemester = 0;

  final _startingRollNo = TextEditingController();
  final _endingRollNo = TextEditingController();
  final _batchSize = TextEditingController();
  TeacherDetailsModel? _teacher;
  List<TeacherDetailsModel> teachers = [];
  late String _department;

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
    HodMiddleWare.fetchTeacherData(_department).then((teahcersList) {
      setState(() {
        teachers = teahcersList;
      });
    });
  }

  bool validateSelections() {
    if (_selectedYear == -1) {
      return false; // Year not selected
    }
    if (_selectedSemester == -1) {
      return false; // Semester not selected
    }
    if (_selectedSection == -1) {
      return false; // Section not selected
    }
    if (_teacher == null) {
      return false; // Teacher not selected
    }
    return true; // All selections valid
  }

  _assignMentor() async {
    if (validateSelections()) {
      final result = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Mentor Confirmation'),
          content: Text(
              "Selected Mentor - ${_teacher!.teacherName}\nBatch Size - ${_batchSize.text}\nStarting Roll No. - ${_startingRollNo.text}\nEnding Roll No. - ${_endingRollNo.text}"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false), // Cancel
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true), // Confirm
              child: const Text('Yes'),
            ),
          ],
        ),
      );

      if (result ?? false) {
        final details = BatchDetails(
          department: _department,
          year: switch (_selectedYear) {
            0 => 'FE',
            1 => 'SE',
            2 => 'TE',
            3 => 'BE',
            _ => 'FE'
          },
          section: switch (_selectedSection) {
            0 => 'A',
            1 => 'B',
            2 => 'C',
            3 => 'D',
            4 => 'E',
            _ => 'A',
          },
          startingRollNo: _startingRollNo.text.trim() as int,
          endingRollNo: _endingRollNo.text.trim() as int,
          batchSize: _batchSize.text.trim() as int,
          teacherID: _teacher!.teacherCollegeID,
          teacherName: _teacher!.teacherName,
        );

        // ignore: use_build_context_synchronously
        await HodMiddleWare.generateBatch(details, context);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Please select all the necessary options"),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: 'Okay',
            onPressed: () {},
          ),
        ),
      );
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
          'Mentor Allotment',
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
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: deviceHeight * 0.03,
                ),
                Text(
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
                SizedBox(
                  height: deviceHeight * 0.03,
                ),
                Text(
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
                SizedBox(
                  height: deviceHeight * 0.03,
                ),
                Text(
                  'Select Section',
                  style: GoogleFonts.getFont(
                    'Readex Pro',
                    textStyle: const TextStyle(
                      color: AppColors.spaceCadet,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
                Wrap(
                  spacing: 8.0, // Space between chips
                  children: List<Widget>.generate(5, (int index) {
                    return ChoiceChip(
                      label: Text(
                        switch (index) {
                          0 => 'A',
                          1 => 'B',
                          2 => 'C',
                          3 => 'D',
                          4 => 'E',
                          _ => 'A',
                        },
                      ),
                      selected: _selectedSection == index,
                      onSelected: (bool selected) {
                        setState(() {
                          _selectedSection = selected
                              ? index
                              : (_selectedSection == -1
                                  ? 0
                                  : -1); // -1 for no selection
                        });
                      },
                      selectedColor: AppColors.silverPink,
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: deviceHeight * 0.03,
                ),
                Text(
                  'Select Mentor',
                  style: GoogleFonts.getFont(
                    'Readex Pro',
                    textStyle: const TextStyle(
                      color: AppColors.spaceCadet,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
                DropdownButtonFormField<TeacherDetailsModel>(
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
                SizedBox(
                  height: deviceHeight * 0.03,
                ),
                Text(
                  'Batch Data',
                  style: GoogleFonts.getFont(
                    'Readex Pro',
                    textStyle: const TextStyle(
                      color: AppColors.spaceCadet,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: deviceWidth * 0.29,
                      child: NormalTextField(
                        controller: _startingRollNo,
                        onChanged: (value) {
                          _startingRollNo.text = value!;
                          _startingRollNo.selection = TextSelection.collapsed(
                              offset: _startingRollNo.text.length);
                        },
                        labelText: 'Starting Roll No.',
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a valid mobile number !';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: deviceWidth * 0.29, // Adjust width as needed
                      child: NormalTextField(
                        controller: _endingRollNo,
                        onChanged: (value) {
                          setState(() {
                            _endingRollNo.text = value!;
                            _endingRollNo.selection = TextSelection.collapsed(
                                offset: _endingRollNo.text.length);
                          });
                        },
                        labelText: 'Ending Roll No.',
                        keyboardType: TextInputType.number, // For numbers
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a valid roll no !';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      width: deviceWidth * 0.29, // Adjust width as needed
                      child: NormalTextField(
                        controller: _batchSize,
                        onChanged: (value) {
                          setState(() {
                            _batchSize.text = value!;
                            _batchSize.selection = TextSelection.collapsed(
                                offset: _batchSize.text.length);
                          });
                        },
                        labelText: 'Batch Size',
                        keyboardType: TextInputType.number, // For numbers
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a valid batch size !';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: deviceHeight * 0.03,
                ),
                AccountButton(
                    buttonText: "Assign Mentor",
                    buttonIcon: const Icon(Icons.add),
                    buttonClicked: _assignMentor)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
