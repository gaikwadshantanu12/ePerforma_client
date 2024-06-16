import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/middleware/hod/hod_mw.dart';
import 'package:student_performance_monitoring_app/models/subject/subject_details.dart';

class ViewAllST extends StatefulWidget {
  const ViewAllST({super.key});

  @override
  State<ViewAllST> createState() => _ViewAllSTState();
}

class _ViewAllSTState extends State<ViewAllST> {
  List<SubjectDetails> subjects = [];
  late String _department;
  List<DataRow> dataTableRows = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    isLoading = true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _department = ModalRoute.of(context)?.settings.arguments as String? ?? '';
    _fetchAllSubjectsAndST();
  }

  void _fetchAllSubjectsAndST() {
    HodMiddleWare.fetchAllSubjectsAndST(_department).then((subjectsList) {
      setState(() {
        subjects = subjectsList;
        dataTableRows = subjects
            .map((subjectDetails) => DataRow(cells: [
                  DataCell(Text(subjectDetails.subjectCode)),
                  DataCell(Text(subjectDetails.subjectName)),
                  DataCell(Text(subjectDetails.teacherName)),
                  DataCell(Text(subjectDetails.semester)),
                  DataCell(Text(subjectDetails.year)),
                  DataCell(Text(subjectDetails.section)),
                ]))
            .toList();

        isLoading = false;
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
          'View ST Allotment',
          style: GoogleFonts.getFont(
            'Outfit',
            color: AppColors.isabelline,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
        elevation: 2,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                headingRowColor:
                    MaterialStateProperty.all(AppColors.silverPink),
                dataRowColor:
                    MaterialStateProperty.all(AppColors.heliotropeGray),
                headingTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: AppColors.spaceCadet,
                ),
                dataTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: AppColors.isabelline,
                ),
                dataRowMaxHeight: 80,
                dataRowMinHeight: 80,
                dividerThickness: 5,
                columns: const [
                  DataColumn(
                    label: Text('Subject Code'),
                  ),
                  DataColumn(
                    label: Text('Subject'),
                  ),
                  DataColumn(
                    label: Text('Teacher'),
                  ),
                  DataColumn(
                    label: Text('Semester'),
                  ),
                  DataColumn(
                    label: Text('Year'),
                  ),
                  DataColumn(
                    label: Text('Section'),
                  ),
                ],
                rows: dataTableRows,
              ),
            ),
    );
  }
}
