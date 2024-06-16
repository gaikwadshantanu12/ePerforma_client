import 'dart:convert';

class SubjectDetails {
  String subjectName;
  String subjectCode;
  String teacherName;
  String teacherID;
  String department;
  String semester;
  String year;
  String section;
  SubjectDetails({
    required this.subjectName,
    required this.subjectCode,
    required this.teacherName,
    required this.teacherID,
    required this.department,
    required this.semester,
    required this.year,
    required this.section,
  });

  SubjectDetails copyWith({
    String? subjectName,
    String? subjectCode,
    String? teacherName,
    String? teacherID,
    String? department,
    String? semester,
    String? year,
    String? section,
  }) {
    return SubjectDetails(
      subjectName: subjectName ?? this.subjectName,
      subjectCode: subjectCode ?? this.subjectCode,
      teacherName: teacherName ?? this.teacherName,
      teacherID: teacherID ?? this.teacherID,
      department: department ?? this.department,
      semester: semester ?? this.semester,
      year: year ?? this.year,
      section: section ?? this.section,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subjectName': subjectName,
      'subjectCode': subjectCode,
      'teacherName': teacherName,
      'teacherID': teacherID,
      'department': department,
      'semester': semester,
      'year': year,
      'section': section,
    };
  }

  factory SubjectDetails.fromMap(Map<String, dynamic> map) {
    return SubjectDetails(
      subjectName: map['subjectName'] ?? '',
      subjectCode: map['subjectCode'] ?? '',
      teacherName: map['teacherName'] ?? '',
      teacherID: map['teacherID'] ?? '',
      department: map['department'] ?? '',
      semester: map['semester'] ?? '',
      year: map['year'] ?? '',
      section: map['section'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SubjectDetails.fromJson(String source) =>
      SubjectDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SubjectDetails(subjectName: $subjectName, subjectCode: $subjectCode, teacherName: $teacherName, teacherID: $teacherID, department: $department, semester: $semester, year: $year, section: $section)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubjectDetails &&
        other.subjectName == subjectName &&
        other.subjectCode == subjectCode &&
        other.teacherName == teacherName &&
        other.teacherID == teacherID &&
        other.department == department &&
        other.semester == semester &&
        other.year == year &&
        other.section == section;
  }

  @override
  int get hashCode {
    return subjectName.hashCode ^
        subjectCode.hashCode ^
        teacherName.hashCode ^
        teacherID.hashCode ^
        department.hashCode ^
        semester.hashCode ^
        year.hashCode ^
        section.hashCode;
  }
}
