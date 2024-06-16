import 'dart:convert';

class BatchDetails {
  String department;
  String year;
  String section;
  int startingRollNo;
  int endingRollNo;
  int batchSize;
  String teacherID;
  String teacherName;
  BatchDetails({
    required this.department,
    required this.year,
    required this.section,
    required this.startingRollNo,
    required this.endingRollNo,
    required this.batchSize,
    required this.teacherID,
    required this.teacherName,
  });

  BatchDetails copyWith({
    String? department,
    String? year,
    String? section,
    int? startingRollNo,
    int? endingRollNo,
    int? batchSize,
    String? teacherID,
    String? teacherName,
  }) {
    return BatchDetails(
      department: department ?? this.department,
      year: year ?? this.year,
      section: section ?? this.section,
      startingRollNo: startingRollNo ?? this.startingRollNo,
      endingRollNo: endingRollNo ?? this.endingRollNo,
      batchSize: batchSize ?? this.batchSize,
      teacherID: teacherID ?? this.teacherID,
      teacherName: teacherName ?? this.teacherName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'department': department,
      'year': year,
      'section': section,
      'startingRollNo': startingRollNo,
      'endingRollNo': endingRollNo,
      'batchSize': batchSize,
      'teacherID': teacherID,
      'teacherName': teacherName,
    };
  }

  factory BatchDetails.fromMap(Map<String, dynamic> map) {
    return BatchDetails(
      department: map['department'] ?? '',
      year: map['year'] ?? '',
      section: map['section'] ?? '',
      startingRollNo: map['startingRollNo']?.toInt() ?? 0,
      endingRollNo: map['endingRollNo']?.toInt() ?? 0,
      batchSize: map['batchSize']?.toInt() ?? 0,
      teacherID: map['teacherID'] ?? '',
      teacherName: map['teacherName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory BatchDetails.fromJson(String source) =>
      BatchDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BatchDetails(department: $department, year: $year, section: $section, startingRollNo: $startingRollNo, endingRollNo: $endingRollNo, batchSize: $batchSize, teacherID: $teacherID, teacherName: $teacherName)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BatchDetails &&
        other.department == department &&
        other.year == year &&
        other.section == section &&
        other.startingRollNo == startingRollNo &&
        other.endingRollNo == endingRollNo &&
        other.batchSize == batchSize &&
        other.teacherID == teacherID &&
        other.teacherName == teacherName;
  }

  @override
  int get hashCode {
    return department.hashCode ^
        year.hashCode ^
        section.hashCode ^
        startingRollNo.hashCode ^
        endingRollNo.hashCode ^
        batchSize.hashCode ^
        teacherID.hashCode ^
        teacherName.hashCode;
  }
}
