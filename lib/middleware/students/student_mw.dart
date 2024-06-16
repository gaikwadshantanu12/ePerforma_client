import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:student_performance_monitoring_app/constants/api.dart';
import 'package:student_performance_monitoring_app/constants/session_manager.dart';
import 'package:student_performance_monitoring_app/constants/widgets/hod/show_pdf.dart';
import 'package:student_performance_monitoring_app/models/notices/notices_details.dart';
import 'package:student_performance_monitoring_app/models/student/student_details.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:student_performance_monitoring_app/models/student_document/student_document_details.dart';

class StudentsMiddleWare {
  static Future<void> registerNewStudent(
      StudentDetailsModel model, BuildContext ctx) async {
    try {
      var url = ApiRoutes.registerNewStudent;
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{"Content-Type": "application/json"},
        body: model.toJson(),
      );

      String responseText = response.body;

      // ignore: use_build_context_synchronously
      showDialog(
        context: ctx,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Registration Status"),
            content: Text(responseText),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushReplacementNamed(
                    context,
                    '/student/student_dashboard_page',
                  );
                },
              ),
            ],
          );
        },
      );
    } catch (e) {
      // ignore: avoid_print
      print("Exception is $e");
    }
  }

  static Future<void> loginExistingStudent(
      String studentEmail, String studentPassword, BuildContext ctx) async {
    Map<String, String> requestBody = {
      'studentEmail': studentEmail,
      'studentPassword': studentPassword
    };
    try {
      var url = ApiRoutes.loginStudent;
      var response = await http.post(Uri.parse(url),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          },
          body: jsonEncode(requestBody));

      if (response.statusCode == 200) {
        StudentDetailsModel model = StudentDetailsModel.fromJson(response.body);
        // ignore: avoid_print
        print(model);

        await SessionManager.setStudentLoggedIn(true);
        await SessionManager.storeStudent(model);
        await SessionManager.setGlobalAppRole('student');

        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(ctx, '/student/student_dashboard_page',
            arguments: model);
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: ctx,
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
      // ignore: avoid_print
      print('Exception is $e');
    }
  }

  static Future<StudentDetailsModel> fetchParticularStudentData(
      String studentID) async {
    StudentDetailsModel model;
    if (studentID.isNotEmpty) {
      Map<String, String> requestBody = {
        'collegeID': studentID,
      };

      try {
        var url = ApiRoutes.getParticularStudent;
        var response = await http.post(
          Uri.parse(url),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          },
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 200) {
          model = StudentDetailsModel.fromJson(response.body);
          return model;
        } else {
          throw Exception('Unexpected status code: ${response.statusCode}');
        }
      } catch (e) {
        throw Exception('Failed to load student : ${e.toString()}');
      }
    } else {
      throw ArgumentError('Student ID cannot be empty');
    }
  }

  static Future<List<NoticesDetailsModel>> fetchNoticesByDepartment(
      String department) async {
    Map<String, String> requestBody = {'department': department};
    try {
      var url = ApiRoutes.noticesByDepartment;
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<NoticesDetailsModel> parsedNoticesList =
            jsonData.map((e) => NoticesDetailsModel.fromMap(e)).toList();

        return parsedNoticesList;
      } else {
        throw Exception('Failed to load notices.');
      }
    } catch (e) {
      throw Exception('Failed to load notices : ${e.toString()}');
    }
  }

  static Future<void> uploadDocument(String studentCollegeID,
      String documentType, File document, BuildContext ctx) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiRoutes.uploadDocuments));

    request.fields['studentCollegeID'] = studentCollegeID;
    request.fields['documentType'] = documentType;
    request.files.add(http.MultipartFile.fromBytes(
        'document', document.readAsBytesSync(),
        filename: path.basename(document.path)));

    var response = await request.send();

    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(content: Text('Document Uploaded Successfully!')));
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(content: Text('Document Not Uploaded!')));
    }
  }

  static Future<List<StudentDocumentDetails>> fetchAllDocuments(
      String studentCollegeID) async {
    Map<String, String> requestBody = {'studentCollegeID': studentCollegeID};

    try {
      var url = ApiRoutes.viewStudentDocuments;
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<StudentDocumentDetails> parsedDocumentsList =
            jsonData.map((e) => StudentDocumentDetails.fromMap(e)).toList();

        return parsedDocumentsList;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to load documents : ${e.toString()}');
    }
  }

  static void downloadAndDisplayFile(
      String studentCollegeID, String fileName, BuildContext ctx) async {
    try {
      final url =
          '${ApiRoutes.downloadDocument}/student_id=$studentCollegeID&filename=$fileName';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        Navigator.push(
          ctx,
          MaterialPageRoute(
            builder: (context) =>
                ShowPDF(pdfBytes: response.bodyBytes, fileName: fileName),
          ),
        );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
