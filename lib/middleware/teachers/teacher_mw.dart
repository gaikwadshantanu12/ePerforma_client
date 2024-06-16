import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:student_performance_monitoring_app/constants/api.dart';
import 'package:student_performance_monitoring_app/models/batches/batch_detail.dart';
import 'package:student_performance_monitoring_app/models/class/class_details.dart';
import 'package:student_performance_monitoring_app/models/lecture_attendance/lecture_attendance_model.dart';
import 'package:student_performance_monitoring_app/models/messages/messages_detail.dart';
import 'package:student_performance_monitoring_app/models/notices/notices_details.dart';
import 'package:student_performance_monitoring_app/models/student/student_details.dart';
import 'package:student_performance_monitoring_app/models/subject/subject_details.dart';
import 'package:student_performance_monitoring_app/models/teacher/teacher_details.dart';
import 'package:student_performance_monitoring_app/constants/session_manager.dart';
import 'package:http/http.dart' as http;

class TeachersMiddleWare {
  static Future<void> registerNewTeacher(
      TeacherDetailsModel model, BuildContext ctx) async {
    try {
      var url = ApiRoutes.registerNewTeacher;
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
                  Navigator.of(context).pop(); // Close the dialog
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

  static Future<void> loginExistingTeacher(
      String teacherEmail, String teacherPassword, BuildContext ctx) async {
    Map<String, String> requestBody = {
      'teacherEmail': teacherEmail,
      'teacherPassword': teacherPassword
    };
    try {
      var url = ApiRoutes.loginTeacher;
      var response = await http.post(Uri.parse(url),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          },
          body: jsonEncode(requestBody));

      if (response.statusCode == 200) {
        TeacherDetailsModel model = TeacherDetailsModel.fromJson(response.body);
        // ignore: avoid_print
        print(model);

        await SessionManager.setTeacherLoggedIn(true);
        await SessionManager.storeTeacher(model);
        await SessionManager.setGlobalAppRole('teacher');

        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(ctx, '/teacher/teacher_dashboard_page',
            arguments: model);
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: ctx,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Login Status"),
              content: const Text(
                  "Teacher Not Found. Please check email and password."),
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

  static Future<List<SubjectDetails>> fetchTeacherSubjects(
      String teacherID) async {
    Map<String, String> requestBody = {'teacherID': teacherID};

    try {
      var url = ApiRoutes.getMyAllSubjects;
      var response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<SubjectDetails> parsedSubjectsList =
            jsonData.map((e) => SubjectDetails.fromMap(e)).toList();

        return parsedSubjectsList;
      } else {
        throw Exception('Failed to load subjects : ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to load subjects : ${e.toString()}');
    }
  }

  // static Future<List<StudentDetailsModel>> fetchStudentsByDeptAndYear(
  //     String department, String year) async {
  //   Map<String, String> requestBody = {
  //     'studentDepartment': department,
  //     'studentCurrentYear': year
  //   };

  //   try {
  //     var url = ApiRoutes.getStudentsAsPerSubjectYear;
  //     var response = await http.post(
  //       Uri.parse(url),
  //       headers: <String, String>{
  //         "Content-Type": "application/json; charset=UTF-8"
  //       },
  //       body: jsonEncode(requestBody),
  //     );

  //     if (response.statusCode == 200) {
  //       List<dynamic> jsonData = jsonDecode(response.body);
  //       List<StudentDetailsModel> parsedStudentsList =
  //           jsonData.map((e) => StudentDetailsModel.fromMap(e)).toList();

  //       return parsedStudentsList;
  //     } else {
  //       throw Exception('Failed to load students : ${response.reasonPhrase}');
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to load students : ${e.toString()}');
  //   }
  // }

  static void showStudentInfoPopup(
      StudentDetailsModel student, BuildContext ctx) {
    showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Student Information"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name : ${student.studentName}"),
              Text("ID : ${student.studentCollegeID}"),
              Text("Roll No : ${student.studentRollNo}"),
              Text("Mobile No : ${student.studentMobile}"),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Close"),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  static Future<String> postAttendance(LectureAttendanceModel model) async {
    try {
      var url = Uri.parse(ApiRoutes.pushAttendance);
      var response = await http.post(
        url,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: model.toJson(),
      );

      if (response.statusCode == 200) {
        return "Attendance Posted";
      } else {
        return "Attendance Not Posted";
      }
    } catch (e) {
      throw Exception('Failed to post attendance : ${e.toString()}');
    }
  }

  static Future<LectureAttendanceModel> getAttendance(
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
      throw Exception("Failed to load attendance for subject $subjectCode");
    } catch (e) {
      throw Exception('Failed to load attendance : ${e.toString()}');
    }
  }

  static Future<List<NoticesDetailsModel>> fetchNoticesByDepartment(
      String department) async {
    Map<String, String> requestBody = {'department': department};
    try {
      var url = ApiRoutes.noticesTeacherByDepartment;
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

  static Future<bool> isClassTeacher(String teacherID) async {
    Map<String, String> requestBody = {
      'teacherCollegeID': teacherID,
    };

    try {
      var url = ApiRoutes.checkTeacherAsClassTeacher;
      var response = await http.post(Uri.parse(url),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          },
          body: jsonEncode(requestBody));

      if (response.statusCode == 200) {
        if (response.body == 'true') {
          return true;
        } else {
          return false;
        }
      }
      throw Exception("Something went wrong while check for class teacher");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<bool> isBatchMentor(String teacherID) async {
    Map<String, String> requestBody = {
      'teacherCollegeID': teacherID,
    };

    try {
      var url = ApiRoutes.checkTeacherAsBatchMentor;
      var response = await http.post(Uri.parse(url),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          },
          body: jsonEncode(requestBody));

      if (response.statusCode == 200) {
        if (response.body == 'true') {
          return true;
        } else {
          return false;
        }
      }
      throw Exception("Something went wrong while check for class teacher");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<ClassDetails> fetchClassByTeacherID(String teacherID) async {
    Map<String, String> requestBody = {
      'teacherCollegeID': teacherID,
    };
    ClassDetails details;
    try {
      var url = ApiRoutes.fetchClassByTeacherID;
      var response = await http.post(Uri.parse(url),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          },
          body: jsonEncode(requestBody));

      if (response.statusCode == 200) {
        details = ClassDetails.fromJson(response.body);
        return details;
      }
      throw Exception(
          "Failed to get class details for teacher id - $teacherID");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<BatchDetails> fetchBatchByTeacherID(String teacherID) async {
    Map<String, String> requestBody = {
      'teacherCollegeID': teacherID,
    };
    BatchDetails details;
    try {
      var url = ApiRoutes.fetchBatchByTeacherID;
      var response = await http.post(Uri.parse(url),
          headers: <String, String>{
            "Content-Type": "application/json; charset=UTF-8"
          },
          body: jsonEncode(requestBody));

      if (response.statusCode == 200) {
        details = BatchDetails.fromJson(response.body);
        return details;
      }
      throw Exception(
          "Failed to get batch details for teacher id - $teacherID");
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<StudentDetailsModel>>
      fetchStudentsByYearSectionAndDepartment(
          String year, String section, String department) async {
    Map<String, String> requestBody = {
      'studentDepartment': department,
      'studentCurrentYear': year,
      'studentCurrentSection': section
    };

    try {
      var url = ApiRoutes.fetchStudentsByDeptYearAndSection;
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

  static Future<List<StudentDetailsModel>> fetchStudentsByBatch(
      String department,
      String year,
      String section,
      String startingRollNo,
      String endingRollNo) async {
    Map<String, String> requestBody = {
      'studentDepartment': department,
      'studentCurrentYear': year,
      'studentCurrentSection': section,
      'studentStartingRollNo': startingRollNo,
      'studentEndingRollNo': endingRollNo,
    };
    try {
      var url = ApiRoutes.fetchStudentsByBatch;
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

  static Future<void> broadcastMessage(
      MessagesDetails details, BuildContext ctx) async {
    try {
      var url = Uri.parse(ApiRoutes.sendMessage);
      var response = await http.post(
        url,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: details.toJson(),
      );

      if (response.statusCode == 200) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(ctx).showSnackBar(
          SnackBar(
            content: const Text('Message sent!'),
            action: SnackBarAction(
              label: 'Okay',
              onPressed: () {},
            ),
          ),
        );
      } else {
        throw Exception('Failed to send');
      }
    } catch (e) {
      throw Exception('Failed to send message : ${e.toString()}');
    }
  }

  static Future<List<MessagesDetails>> getMessagesByTeacherID(
      String teacherID) async {
    Map<String, String> requestBody = {
      'teacherCollegeID': teacherID,
    };
    try {
      var url = Uri.parse(ApiRoutes.getMessages);
      var response = await http.post(
        url,
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonData = jsonDecode(response.body);
        List<MessagesDetails> parsedMessagesList =
            jsonData.map((e) => MessagesDetails.fromMap(e)).toList();

        return parsedMessagesList;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception('Failed to load message : ${e.toString()}');
    }
  }
}
