import 'dart:convert';

class LectureAttendanceModel {
  String subjectCode;
  String attendance;
  LectureAttendanceModel({
    required this.subjectCode,
    required this.attendance,
  });

  LectureAttendanceModel copyWith({
    String? subjectCode,
    String? attendance,
  }) {
    return LectureAttendanceModel(
      subjectCode: subjectCode ?? this.subjectCode,
      attendance: attendance ?? this.attendance,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subjectCode': subjectCode,
      'attendance': attendance,
    };
  }

  factory LectureAttendanceModel.fromMap(Map<String, dynamic> map) {
    return LectureAttendanceModel(
      subjectCode: map['subjectCode'] ?? '',
      attendance: map['attendance'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory LectureAttendanceModel.fromJson(String source) =>
      LectureAttendanceModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'LectureAttendanceModel(subjectCode: $subjectCode, attendance: $attendance)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LectureAttendanceModel &&
        other.subjectCode == subjectCode &&
        other.attendance == attendance;
  }

  @override
  int get hashCode => subjectCode.hashCode ^ attendance.hashCode;
}
