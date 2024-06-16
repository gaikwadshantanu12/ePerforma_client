import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:student_performance_monitoring_app/constants/api.dart';
import 'package:student_performance_monitoring_app/constants/session_manager.dart';
import 'package:student_performance_monitoring_app/constants/widgets/hod/show_pdf.dart';
import 'package:student_performance_monitoring_app/models/batches/batch_detail.dart';
import 'package:student_performance_monitoring_app/models/class/class_details.dart';
import 'package:student_performance_monitoring_app/models/hod/hod_details.dart';
import 'package:student_performance_monitoring_app/models/lecture_attendance/lecture_attendance_model.dart';
import 'package:student_performance_monitoring_app/models/notices/notices_details.dart';
import 'package:student_performance_monitoring_app/models/student/student_details.dart';
import 'package:student_performance_monitoring_app/models/student_document/student_document_details.dart';
import 'package:student_performance_monitoring_app/models/subject/subject_details.dart';
import 'package:student_performance_monitoring_app/models/teacher/teacher_details.dart';

class HodMiddleWare {
  static Future<void> loginExistingHod(
      String email, String password, BuildContext ctx) async {
    Map<String, String> requestBody = {
      'hodEmail': email,
      'hodPassword': password
    };

    try {
      var url = ApiRoutes.loginHod;
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        HodDetailsModel model = HodDetailsModel.fromJson(response.body);

        await SessionManager.setHodLoggedIn(true);
        await SessionManager.storeHod(model);
        await SessionManager.setGlobalAppRole('hod');

        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(ctx, '/hod/hod_dashboard_page',
            arguments: model);
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: ctx,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Login Status"),
              content:
                  const Text("HOD Not Found. Please check email and password."),
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
      throw Exception(e.toString());
    }
  }

  static Future<List<NoticesDetailsModel>> fetchAllNotices(
      String hodCollegeID) async {
    Map<String, String> requestBody = {'hodCollegeID': hodCollegeID};

    try {
      var url = ApiRoutes.getNoticesOfParticularHOD;
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
        return [];
      }
    } catch (e) {
      throw Exception('Failed to load notices : ${e.toString()}');
    }
  }

  static Future<StreamedResponse> sendNewNotice(
      String hodID,
      String hodDepartment,
      String noticeTitle,
      String noticeMessage,
      File? selectedFile,
      String? fileName) async {
    var request =
        http.MultipartRequest('POST', Uri.parse(ApiRoutes.addNewNotice));

    request.fields['noticeTitle'] = noticeTitle;
    request.fields['noticeMessage'] = noticeMessage;
    request.fields['hodDepartment'] = hodDepartment;
    request.fields['hodCollegeID'] = hodID;

    request.files.add(http.MultipartFile.fromBytes(
        'noticeFile', selectedFile!.readAsBytesSync(),
        filename: fileName));

    var response = await request.send();

    return response;
  }

  static void downloadAndDisplayFile(
      String hodID, String fileName, BuildContext ctx) async {
    try {
      final url = '${ApiRoutes.downloadFile}/hod_id=$hodID&filename=$fileName';
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

  static Future<void> deleteNoticeDB(int noticeId, BuildContext ctx) async {
    try {
      final String url =
          '${ApiRoutes.deleteNotice}/noticeID=$noticeId'; // Replace with your Spring Boot endpoint
      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(ctx).showSnackBar(
            const SnackBar(content: Text('Notice Deleted Successfully !')));
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(ctx).showSnackBar(
            const SnackBar(content: Text('Notice Not Deleted !')));
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<StudentDetailsModel>>
      fetchDepartmentYearAndSectionWiseStudentsList(
          String department, String year, String section) async {
    Map<String, String> requestBody = {
      'studentDepartment': department,
      'studentCurrentYear': year,
      'studentCurrentSection': section
    };

    try {
      var url = ApiRoutes.deptYearAndSectionWiseStudents;
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(requestBody),
      );
      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<StudentDetailsModel> parsedStudentsList =
            jsonData.map((e) => StudentDetailsModel.fromMap(e)).toList();

        return parsedStudentsList;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to load students : ${e.toString()}');
    }
  }

  static Future<List<TeacherDetailsModel>> fetchDepartmentWiseTeachers(
      String department) async {
    Map<String, String> requestBody = {
      'teacherDepartment': department,
    };

    try {
      var url = ApiRoutes.depatWiseTeachers;
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<TeacherDetailsModel> parsedTeachersList =
            jsonData.map((e) => TeacherDetailsModel.fromMap(e)).toList();

        return parsedTeachersList;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to load teachers : ${e.toString()}');
    }
  }

  static Future<void> generateClassAndCT(
      ClassDetails model, BuildContext ctx) async {
    try {
      var url = ApiRoutes.createClass;
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: model.toJson(),
      );

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(
            content: Text(response.body.toString()),
            duration: const Duration(seconds: 2),
            action: SnackBarAction(
              label: 'Okay',
              onPressed: () {},
            ),
          ),
        );
      }
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<List<TeacherDetailsModel>> fetchTeacherData(
      String department) async {
    if (department.isNotEmpty) {
      Map<String, String> requestBody = {
        'teacherDepartment': department,
      };
      try {
        var url = ApiRoutes.depatWiseTeachers;
        var response = await http.post(
          Uri.parse(url),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          },
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 200) {
          List<dynamic> jsonData = jsonDecode(response.body);
          List<TeacherDetailsModel> parsedTeachersList =
              jsonData.map((e) => TeacherDetailsModel.fromMap(e)).toList();

          return parsedTeachersList;
        } else {
          return [];
        }
      } catch (e) {
        throw Exception('Failed to load teachers : ${e.toString()}');
      }
    } else {
      return [];
    }
  }

  static Future<void> generateSubject(
      SubjectDetails model, BuildContext ctx) async {
    try {
      var url = ApiRoutes.createSubject;
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: model.toJson(),
      );

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(
            content: Text(response.body.toString()),
            duration: const Duration(seconds: 2),
            action: SnackBarAction(
              label: 'Okay',
              onPressed: () {},
            ),
          ),
        );
      }
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<List<ClassDetails>> fetchEntireClass(String department) async {
    // ignore: unnecessary_null_comparison
    if (department != null && department.isNotEmpty) {
      Map<String, String> requestBody = {
        'department': department,
      };
      try {
        var url = ApiRoutes.viewClasses;
        var response = await http.post(
          Uri.parse(url),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          },
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 200) {
          List<dynamic> jsonData = jsonDecode(response.body);
          List<ClassDetails> parsedClassList =
              jsonData.map((e) => ClassDetails.fromMap(e)).toList();

          return parsedClassList;
        } else {
          throw Exception(
              'Failed to load classes and teachers : ${response.reasonPhrase}');
        }
      } catch (e) {
        throw Exception(
            'Failed to load classes and teachers : ${e.toString()}');
      }
    } else {
      return [];
    }
  }

  static Future<void> deleteClass(
      ClassDetails details, BuildContext ctx) async {
    try {
      var url = ApiRoutes.deleteClass;
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: details.toJson(),
      );

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(
            content: Text(response.body.toString()),
            duration: const Duration(seconds: 2),
            action: SnackBarAction(
              label: 'Okay',
              onPressed: () {},
            ),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<List<SubjectDetails>> fetchAllSubjectsAndST(
      String department) async {
    // ignore: unnecessary_null_comparison
    if (department != null && department.isNotEmpty) {
      Map<String, String> requestBody = {
        'department': department,
      };
      try {
        var url = ApiRoutes.viewSubjects;
        var response = await http.post(
          Uri.parse(url),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          },
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 200) {
          List<dynamic> jsonData = jsonDecode(response.body);
          List<SubjectDetails> parsedSubjectList =
              jsonData.map((e) => SubjectDetails.fromMap(e)).toList();

          return parsedSubjectList;
        } else {
          throw Exception(
              'Failed to load subjects and teachers : ${response.reasonPhrase}');
        }
      } catch (e) {
        throw Exception(
            'Failed to load subjects and teachers : ${e.toString()}');
      }
    } else {
      return [];
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

  static void downloadAndDisplayStudentDocumentFile(
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

  static Future<List<SubjectDetails>> fetchAllSubjectsByYearAndDepartment(
      String department, String year) async {
    // ignore: unnecessary_null_comparison
    if (department != null && department.isNotEmpty) {
      Map<String, String> requestBody = {
        'department': department,
        'year': year
      };
      try {
        var url = ApiRoutes.viewSubjectsByYearAndDepartment;
        var response = await http.post(
          Uri.parse(url),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          },
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 200) {
          List<dynamic> jsonData = jsonDecode(response.body);
          List<SubjectDetails> parsedSubjectList =
              jsonData.map((e) => SubjectDetails.fromMap(e)).toList();

          return parsedSubjectList;
        } else {
          throw Exception(
              'Failed to load subjects and teachers : ${response.reasonPhrase}');
        }
      } catch (e) {
        throw Exception(
            'Failed to load subjects and teachers : ${e.toString()}');
      }
    } else {
      return [];
    }
  }

  static Future<LectureAttendanceModel> getSubjectAttendance(
      String subjectCode) async {
    Map<String, String> requestBody = {
      'subjectCode': subjectCode,
    };
    LectureAttendanceModel model;
    try {
      var url = Uri.parse(ApiRoutes.getAttendance);
      var response = await http.post(url,
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          },
          body: jsonEncode(requestBody));

      if (response.statusCode == 200) {
        model = LectureAttendanceModel.fromJson(response.body);
        return model;
      }
      throw Exception("Failed to load attendance");
    } catch (e) {
      throw Exception('Failed to load attendance : ${e.toString()}');
    }
  }

  static Future<void> generateBatch(
      BatchDetails model, BuildContext ctx) async {
    try {
      var url = ApiRoutes.createBatch;
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: model.toJson(),
      );

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(
            content: Text(response.body.toString()),
            duration: const Duration(seconds: 2),
            action: SnackBarAction(
              label: 'Okay',
              onPressed: () {},
            ),
          ),
        );
      }
    } catch (e) {
      throw e.toString();
    }
  }

  static Future<List<BatchDetails>> fetchBatches(String department) async {
    // ignore: unnecessary_null_comparison
    if (department != null && department.isNotEmpty) {
      Map<String, String> requestBody = {
        'department': department,
      };
      try {
        var url = ApiRoutes.viewBatches;
        var response = await http.post(
          Uri.parse(url),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          },
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 200) {
          List<dynamic> jsonData = jsonDecode(response.body);
          List<BatchDetails> parsedBatchList =
              jsonData.map((e) => BatchDetails.fromMap(e)).toList();

          return parsedBatchList;
        } else {
          throw Exception('Failed to load batches : ${response.reasonPhrase}');
        }
      } catch (e) {
        throw Exception('Failed to load batches : ${e.toString()}');
      }
    } else {
      return [];
    }
  }

  static Future<void> deleteBatch(
      BatchDetails details, BuildContext ctx) async {
    try {
      var url = ApiRoutes.deleteBatch;
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: details.toJson(),
      );

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(
            content: Text(response.body.toString()),
            duration: const Duration(seconds: 2),
            action: SnackBarAction(
              label: 'Okay',
              onPressed: () {},
            ),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
  }
}
