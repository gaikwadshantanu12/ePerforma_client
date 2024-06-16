import 'dart:convert';

class StudentDetailsModel {
  String studentCollegeID;
  String studentName;
  String studentPersonalEmail;
  String studentMobile;
  String studentPassword;
  String studentDepartment;
  String studentCurrentYear;
  int studentRollNo;
  String studentCollegeEmail;
  String studentProfilePhoto;
  String studentCurrentSection;

  StudentDetailsModel({
    required this.studentCollegeID,
    required this.studentName,
    required this.studentPersonalEmail,
    required this.studentMobile,
    required this.studentPassword,
    required this.studentDepartment,
    required this.studentCurrentYear,
    required this.studentRollNo,
    required this.studentCollegeEmail,
    required this.studentProfilePhoto,
    required this.studentCurrentSection,
  });

  StudentDetailsModel copyWith({
    String? studentCollegeID,
    String? studentName,
    String? studentPersonalEmail,
    String? studentMobile,
    String? studentPassword,
    String? studentDepartment,
    String? studentCurrentYear,
    int? studentRollNo,
    String? studentCollegeEmail,
    String? studentProfilePhoto,
    String? studentCurrentSection,
  }) {
    return StudentDetailsModel(
      studentCollegeID: studentCollegeID ?? this.studentCollegeID,
      studentName: studentName ?? this.studentName,
      studentPersonalEmail: studentPersonalEmail ?? this.studentPersonalEmail,
      studentMobile: studentMobile ?? this.studentMobile,
      studentPassword: studentPassword ?? this.studentPassword,
      studentDepartment: studentDepartment ?? this.studentDepartment,
      studentCurrentYear: studentCurrentYear ?? this.studentCurrentYear,
      studentRollNo: studentRollNo ?? this.studentRollNo,
      studentCollegeEmail: studentCollegeEmail ?? this.studentCollegeEmail,
      studentProfilePhoto: studentProfilePhoto ?? this.studentProfilePhoto,
      studentCurrentSection:
          studentCurrentSection ?? this.studentCurrentSection,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'studentCollegeID': studentCollegeID,
      'studentName': studentName,
      'studentPersonalEmail': studentPersonalEmail,
      'studentMobile': studentMobile,
      'studentPassword': studentPassword,
      'studentDepartment': studentDepartment,
      'studentCurrentYear': studentCurrentYear,
      'studentRollNo': studentRollNo,
      'studentCollegeEmail': studentCollegeEmail,
      'studentProfilePhoto': studentProfilePhoto,
      'studentCurrentSection': studentCurrentSection,
    };
  }

  factory StudentDetailsModel.fromMap(Map<String, dynamic> map) {
    return StudentDetailsModel(
      studentCollegeID: map['studentCollegeID'] ?? '',
      studentName: map['studentName'] ?? '',
      studentPersonalEmail: map['studentPersonalEmail'] ?? '',
      studentMobile: map['studentMobile'] ?? '',
      studentPassword: map['studentPassword'] ?? '',
      studentDepartment: map['studentDepartment'] ?? '',
      studentCurrentYear: map['studentCurrentYear'] ?? '',
      studentRollNo: map['studentRollNo']?.toInt() ?? 0,
      studentCollegeEmail: map['studentCollegeEmail'] ?? '',
      studentProfilePhoto: map['studentProfilePhoto'] ?? '',
      studentCurrentSection: map['studentCurrentSection'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentDetailsModel.fromJson(String source) =>
      StudentDetailsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'StudentDetailsModel(studentCollegeID: $studentCollegeID, studentName: $studentName, studentPersonalEmail: $studentPersonalEmail, studentMobile: $studentMobile, studentPassword: $studentPassword, studentDepartment: $studentDepartment, studentCurrentYear: $studentCurrentYear, studentRollNo: $studentRollNo, studentCollegeEmail: $studentCollegeEmail, studentProfilePhoto: $studentProfilePhoto, studentCurrentSection: $studentCurrentSection)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StudentDetailsModel &&
        other.studentCollegeID == studentCollegeID &&
        other.studentName == studentName &&
        other.studentPersonalEmail == studentPersonalEmail &&
        other.studentMobile == studentMobile &&
        other.studentPassword == studentPassword &&
        other.studentDepartment == studentDepartment &&
        other.studentCurrentYear == studentCurrentYear &&
        other.studentRollNo == studentRollNo &&
        other.studentCollegeEmail == studentCollegeEmail &&
        other.studentProfilePhoto == studentProfilePhoto &&
        other.studentCurrentSection == studentCurrentSection;
  }

  @override
  int get hashCode {
    return studentCollegeID.hashCode ^
        studentName.hashCode ^
        studentPersonalEmail.hashCode ^
        studentMobile.hashCode ^
        studentPassword.hashCode ^
        studentDepartment.hashCode ^
        studentCurrentYear.hashCode ^
        studentRollNo.hashCode ^
        studentCollegeEmail.hashCode ^
        studentProfilePhoto.hashCode ^
        studentCurrentSection.hashCode;
  }
}
