import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/middleware/hod/hod_mw.dart';
import 'package:student_performance_monitoring_app/models/batches/batch_detail.dart';

class ViewMT extends StatefulWidget {
  const ViewMT({super.key});

  @override
  State<ViewMT> createState() => _ViewMTState();
}

class _ViewMTState extends State<ViewMT> {
  List<BatchDetails> batches = [];
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
    _fetchBatches();
  }

  void _fetchBatches() {
    HodMiddleWare.fetchBatches(_department).then((batchesList) {
      setState(() {
        batches = batchesList;
        dataTableRows =
            batches.map((batchDetails) => _buildDataRow(batchDetails)).toList();
        isLoading = false;
      });
    });
  }

  DataRow _buildDataRow(BatchDetails batches) {
    return DataRow(
      cells: [
        DataCell(Text(batches.teacherName)),
        DataCell(Text(batches.year)),
        DataCell(Text(batches.section)),
        DataCell(Text(batches.startingRollNo.toString())),
        DataCell(Text(batches.endingRollNo.toString())),
        DataCell(Text(batches.batchSize.toString())),
      ],
      onLongPress: () => _showDeleteConfirmationDialog(batches),
    );
  }

  void _showDeleteConfirmationDialog(BatchDetails batchDetails) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Confirmation'),
          content: Text(
              'Are you sure you want to delete the batch assignment for ${batchDetails.teacherName} with details :\nYear - ${batchDetails.year}\nSection - ${batchDetails.section}\nBatch Size - ${batchDetails.batchSize}\nStarting Roll No - ${batchDetails.startingRollNo}\nEnding Roll No - ${batchDetails.endingRollNo}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Implement logic to delete the class assignment (call a method from HodMiddleWare)
                // Update UI after successful deletion (e.g., remove the row)
                HodMiddleWare.deleteBatch(batchDetails, context);
                Navigator.pop(context);
                setState(() {
                  batches.remove(batchDetails);
                  dataTableRows = batches
                      .map((batchDetails) => _buildDataRow(batchDetails))
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
          'View MT Allotment',
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
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columnSpacing: MediaQuery.of(context).size.width / 4,
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
                      label: Text('Teacher Name'),
                    ),
                    DataColumn(
                      label: Text('Year'),
                    ),
                    DataColumn(
                      label: Text('Section'),
                    ),
                    DataColumn(
                      label: Text('Starting Roll No'),
                    ),
                    DataColumn(
                      label: Text('Ending Roll No'),
                    ),
                    DataColumn(
                      label: Text('Batch Size'),
                    ),
                  ],
                  rows: dataTableRows,
                ),
              ),
            ),
    );
  }
}
