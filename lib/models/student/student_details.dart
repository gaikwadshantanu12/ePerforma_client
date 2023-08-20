import 'dart:convert';

class StudentDetailsModel {
  String studentCollegeID;
  String studentName;
  String studentEmail;
  String studentPassword;
  String studentDepartment;

  StudentDetailsModel({
    required this.studentCollegeID,
    required this.studentName,
    required this.studentEmail,
    required this.studentPassword,
    required this.studentDepartment,
  });

  StudentDetailsModel copyWith({
    String? studentCollegeID,
    String? studentName,
    String? studentEmail,
    String? studentPassword,
    String? studentDepartment,
  }) {
    return StudentDetailsModel(
      studentCollegeID: studentCollegeID ?? this.studentCollegeID,
      studentName: studentName ?? this.studentName,
      studentEmail: studentEmail ?? this.studentEmail,
      studentPassword: studentPassword ?? this.studentPassword,
      studentDepartment: studentDepartment ?? this.studentDepartment,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'studentCollegeID': studentCollegeID,
      'studentName': studentName,
      'studentEmail': studentEmail,
      'studentPassword': studentPassword,
      'studentDepartment': studentDepartment,
    };
  }

  factory StudentDetailsModel.fromMap(Map<String, dynamic> map) {
    return StudentDetailsModel(
      studentCollegeID: map['studentCollegeID'] ?? '',
      studentName: map['studentName'] ?? '',
      studentEmail: map['studentEmail'] ?? '',
      studentPassword: map['studentPassword'] ?? '',
      studentDepartment: map['studentDepartment'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentDetailsModel.fromJson(String source) =>
      StudentDetailsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StudentDetailsModel(studentCollegeID: $studentCollegeID, studentName: $studentName, studentEmail: $studentEmail, studentPassword: $studentPassword, studentDepartment: $studentDepartment)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StudentDetailsModel &&
        other.studentCollegeID == studentCollegeID &&
        other.studentName == studentName &&
        other.studentEmail == studentEmail &&
        other.studentPassword == studentPassword &&
        other.studentDepartment == studentDepartment;
  }

  @override
  int get hashCode {
    return studentCollegeID.hashCode ^
        studentName.hashCode ^
        studentEmail.hashCode ^
        studentPassword.hashCode ^
        studentDepartment.hashCode;
  }
}
