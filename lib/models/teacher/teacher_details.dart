import 'dart:convert';

class TeacherDetailsModel {
  String teacherCollegeID;
  String teacherName;
  String teacherEmail;
  String teacherPassword;
  String teacherDepartment;

  TeacherDetailsModel({
    required this.teacherCollegeID,
    required this.teacherName,
    required this.teacherEmail,
    required this.teacherPassword,
    required this.teacherDepartment,
  });

  TeacherDetailsModel copyWith({
    String? teacherCollegeID,
    String? teacherName,
    String? teacherEmail,
    String? teacherPassword,
    String? teacherDepartment,
  }) {
    return TeacherDetailsModel(
      teacherCollegeID: teacherCollegeID ?? this.teacherCollegeID,
      teacherName: teacherName ?? this.teacherName,
      teacherEmail: teacherEmail ?? this.teacherEmail,
      teacherPassword: teacherPassword ?? this.teacherPassword,
      teacherDepartment: teacherDepartment ?? this.teacherDepartment,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'teacherCollegeID': teacherCollegeID,
      'teacherName': teacherName,
      'teacherEmail': teacherEmail,
      'teacherPassword': teacherPassword,
      'teacherDepartment': teacherDepartment,
    };
  }

  factory TeacherDetailsModel.fromMap(Map<String, dynamic> map) {
    return TeacherDetailsModel(
      teacherCollegeID: map['teacherCollegeID'] ?? '',
      teacherName: map['teacherName'] ?? '',
      teacherEmail: map['teacherEmail'] ?? '',
      teacherPassword: map['teacherPassword'] ?? '',
      teacherDepartment: map['teacherDepartment'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory TeacherDetailsModel.fromJson(String source) =>
      TeacherDetailsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TeacherDetailsModel(teacherCollegeID: $teacherCollegeID, teacherName: $teacherName, teacherEmail: $teacherEmail, teacherPassword: $teacherPassword, teacherDepartment: $teacherDepartment)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TeacherDetailsModel &&
        other.teacherCollegeID == teacherCollegeID &&
        other.teacherName == teacherName &&
        other.teacherEmail == teacherEmail &&
        other.teacherPassword == teacherPassword &&
        other.teacherDepartment == teacherDepartment;
  }

  @override
  int get hashCode {
    return teacherCollegeID.hashCode ^
        teacherName.hashCode ^
        teacherEmail.hashCode ^
        teacherPassword.hashCode ^
        teacherDepartment.hashCode;
  }
}
