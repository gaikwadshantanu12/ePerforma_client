import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/middleware/hod/hod_mw.dart';
import 'package:student_performance_monitoring_app/models/class/class_details.dart';

class ViewAllCT extends StatefulWidget {
  const ViewAllCT({super.key});

  @override
  State<ViewAllCT> createState() => _ViewAllCTState();
}

class _ViewAllCTState extends State<ViewAllCT> {
  List<ClassDetails> classes = [];
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
    _fetchEntireClass();
  }

  void _fetchEntireClass() {
    HodMiddleWare.fetchEntireClass(_department).then((classesList) {
      setState(() {
        classes = classesList;
        dataTableRows =
            classes.map((classDetails) => _buildDataRow(classDetails)).toList();
        isLoading = false;
      });
    });
  }

  DataRow _buildDataRow(ClassDetails classDetails) {
    return DataRow(
      cells: [
        DataCell(Text(classDetails.teacherName)),
        DataCell(Text("${classDetails.year} - ${classDetails.section}")),
      ],
      onLongPress: () => _showDeleteConfirmationDialog(classDetails),
    );
  }

  void _showDeleteConfirmationDialog(ClassDetails classDetails) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Confirmation'),
          content: Text(
              'Are you sure you want to delete the class assignment for ${classDetails.teacherName} in ${classDetails.year}-${classDetails.section}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Implement logic to delete the class assignment (call a method from HodMiddleWare)
                // Update UI after successful deletion (e.g., remove the row)
                HodMiddleWare.deleteClass(classDetails, context);
                Navigator.pop(context);
                setState(() {
                  classes.remove(classDetails);
                  dataTableRows = classes
                      .map((classDetails) => _buildDataRow(classDetails))
                      .toList();
                });
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
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
          'View CT Allotment',
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
              scrollDirection: Axis.vertical,
              child: DataTable(
                columnSpacing: MediaQuery.of(context).size.width / 2,
                headingRowColor:
                    MaterialStateProperty.all(AppColors.silverPink),
                dataRowColor:
                    MaterialStateProperty.all(AppColors.heliotropeGray),
                headingTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
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
                    label: Text('Teacher'),
                  ),
                  DataColumn(
                    label: Text('Class'),
                  ),
                ],
                rows: dataTableRows,
              ),
            ),
    );
  }
}
