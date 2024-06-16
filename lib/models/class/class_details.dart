import 'dart:convert';

class ClassDetails {
  String year;
  String section;
  String department;
  String teacherName;
  String teacherID;

  ClassDetails({
    required this.year,
    required this.section,
    required this.department,
    required this.teacherName,
    required this.teacherID,
  });

  ClassDetails copyWith({
    String? year,
    String? section,
    String? department,
    String? teacherName,
    String? teacherID,
  }) {
    return ClassDetails(
      year: year ?? this.year,
      section: section ?? this.section,
      department: department ?? this.department,
      teacherName: teacherName ?? this.teacherName,
      teacherID: teacherID ?? this.teacherID,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'year': year,
      'section': section,
      'department': department,
      'teacherName': teacherName,
      'teacherID': teacherID,
    };
  }

  factory ClassDetails.fromMap(Map<String, dynamic> map) {
    return ClassDetails(
      year: map['year'] ?? '',
      section: map['section'] ?? '',
      department: map['department'] ?? '',
      teacherName: map['teacherName'] ?? '',
      teacherID: map['teacherID'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ClassDetails.fromJson(String source) =>
      ClassDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ClassDetails(year: $year, section: $section, department: $department, teacherName: $teacherName, teacherID: $teacherID)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ClassDetails &&
        other.year == year &&
        other.section == section &&
        other.department == department &&
        other.teacherName == teacherName &&
        other.teacherID == teacherID;
  }

  @override
  int get hashCode {
    return year.hashCode ^
        section.hashCode ^
        department.hashCode ^
        teacherName.hashCode ^
        teacherID.hashCode;
  }
}
