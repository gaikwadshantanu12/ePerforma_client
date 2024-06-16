import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_performance_monitoring_app/models/hod/hod_details.dart';
import 'package:student_performance_monitoring_app/models/student/student_details.dart';
import 'package:student_performance_monitoring_app/models/teacher/teacher_details.dart';

class SessionManager {
  static const String _student = 'student';
  static const String _teacher = 'teacher';
  static const String _hod = 'hod';
  static const String _globalRole = 'role';

  /* Define Global App Role */
  static Future<void> setGlobalAppRole(String role) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_globalRole, role);
  }

  /* Get Global App Role */
  static Future<String?> getGlobalAppRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_globalRole);
  }

  /* Student Session Management */
  static Future<bool> isStudentLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_student) ?? false;
  }

  static Future<void> setStudentLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_student, value);
  }

  static Future<void> logoutStudent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_student);
  }

  static Future<void> storeStudent(StudentDetailsModel model) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_student, json.encode(model.toJson()));
  }

  static Future<StudentDetailsModel?> getStoredStudent() async {
    final prefs = await SharedPreferences.getInstance();
    final String? studentJson = prefs.getString(_student);
    if (studentJson != null) {
      return StudentDetailsModel.fromJson(json.decode(studentJson));
    }
    return null;
  }

  static Future<void> removeStoredStudent() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_student);
  }

  /* Teacher Session Management */
  static Future<bool> isTeacherLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_teacher) ?? false;
  }

  static Future<void> setTeacherLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_teacher, value);
  }

  static Future<void> logoutTeacher() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_teacher);
  }

  static Future<void> storeTeacher(TeacherDetailsModel model) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_teacher, json.encode(model.toJson()));
  }

  static Future<TeacherDetailsModel?> getStoredTeacher() async {
    final prefs = await SharedPreferences.getInstance();
    final String? teacherJson = prefs.getString(_teacher);
    if (teacherJson != null) {
      return TeacherDetailsModel.fromJson(json.decode(teacherJson));
    }
    return null;
  }

  static Future<void> removeStoredTeacher() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_teacher);
  }

  /* HOD Session Management */
  static Future<bool> isHodLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_hod) ?? false;
  }

  static Future<void> setHodLoggedIn(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hod, value);
  }

  static Future<void> logoutHod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_hod);
  }

  static Future<void> storeHod(HodDetailsModel model) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_hod, json.encode(model.toJson()));
  }

  static Future<HodDetailsModel?> getStoredHod() async {
    final prefs = await SharedPreferences.getInstance();
    final String? hodJson = prefs.getString(_hod);
    if (hodJson != null) {
      return HodDetailsModel.fromJson(json.decode(hodJson));
    }
    return null;
  }
}
