import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/default_animation.dart';
import 'package:student_performance_monitoring_app/middleware/students/student_mw.dart';
import 'package:student_performance_monitoring_app/models/student_document/student_document_details.dart';

class ViewUploadedDocuments extends StatefulWidget {
  const ViewUploadedDocuments({super.key});

  @override
  State<ViewUploadedDocuments> createState() => _ViewUploadedDocumentsState();
}

class _ViewUploadedDocumentsState extends State<ViewUploadedDocuments> {
  List<StudentDocumentDetails> _documents = [];
  bool isLoading = true;
  late String _studentCollegeID;

  @override
  void initState() {
    super.initState();
    isLoading = true;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _studentCollegeID =
        ModalRoute.of(context)?.settings.arguments as String? ?? '';
    if (isLoading) {
      _fetchData();
    }
  }

  void _fetchData() {
    StudentsMiddleWare.fetchAllDocuments(_studentCollegeID).then((documents) {
      setState(() {
        _documents = documents;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.spaceCadet,
        automaticallyImplyLeading: true,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: AppColors.spaceCadet),
        title: Text(
          'View Documents',
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
          : _documents.isEmpty
              ? DefaultAnimationMessage(
                  animationFile: "assets/lottie_animations/no_data_found.json",
                  animationMessage: "Oopps !!! No documents uploaded yet. ",
                  deviceWidth: width,
                  deviceHeight: height,
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: _documents.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () => StudentsMiddleWare.downloadAndDisplayFile(
                          _studentCollegeID,
                          _documents[index].documentName,
                          context),
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        color: AppColors.isabelline,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              width: width * 0.3,
                              height: height * 0.15,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Image.network(
                                'https://t4.ftcdn.net/jpg/06/72/10/55/240_F_672105514_MwVoFzzHW2zHXG3MXT4l1CTZgH04B1gY.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              _documents[index].documentType,
                              style: GoogleFonts.getFont(
                                "Readex Pro",
                                textStyle: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
    );
  }
}
