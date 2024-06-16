import 'dart:convert';

class NoticesDetailsModel {
  int noticeID;
  String noticeTitle;
  String noticeMessage;
  String noticeFileName;
  String hodCollegeID;
  String hodDepartment;

  NoticesDetailsModel({
    required this.noticeID,
    required this.noticeTitle,
    required this.noticeMessage,
    required this.noticeFileName,
    required this.hodCollegeID,
    required this.hodDepartment,
  });

  NoticesDetailsModel copyWith({
    int? noticeID,
    String? noticeTitle,
    String? noticeMessage,
    String? noticeFileName,
    String? hodCollegeID,
    String? hodDepartment,
  }) {
    return NoticesDetailsModel(
      noticeID: noticeID ?? this.noticeID,
      noticeTitle: noticeTitle ?? this.noticeTitle,
      noticeMessage: noticeMessage ?? this.noticeMessage,
      noticeFileName: noticeFileName ?? this.noticeFileName,
      hodCollegeID: hodCollegeID ?? this.hodCollegeID,
      hodDepartment: hodDepartment ?? this.hodDepartment,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'noticeID': noticeID,
      'noticeTitle': noticeTitle,
      'noticeMessage': noticeMessage,
      'noticeFileName': noticeFileName,
      'hodCollegeID': hodCollegeID,
      'hodDepartment': hodDepartment,
    };
  }

  factory NoticesDetailsModel.fromMap(Map<String, dynamic> map) {
    return NoticesDetailsModel(
      noticeID: map['noticeID']?.toInt() ?? 0,
      noticeTitle: map['noticeTitle'] ?? '',
      noticeMessage: map['noticeMessage'] ?? '',
      noticeFileName: map['noticeFileName'] ?? '',
      hodCollegeID: map['hodCollegeID'] ?? '',
      hodDepartment: map['hodDepartment'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory NoticesDetailsModel.fromJson(String source) =>
      NoticesDetailsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'NoticesDetailsModel(noticeID: $noticeID, noticeTitle: $noticeTitle, noticeMessage: $noticeMessage, noticeFileName: $noticeFileName, hodCollegeID: $hodCollegeID, hodDepartment: $hodDepartment)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NoticesDetailsModel &&
        other.noticeID == noticeID &&
        other.noticeTitle == noticeTitle &&
        other.noticeMessage == noticeMessage &&
        other.noticeFileName == noticeFileName &&
        other.hodCollegeID == hodCollegeID &&
        other.hodDepartment == hodDepartment;
  }

  @override
  int get hashCode {
    return noticeID.hashCode ^
        noticeTitle.hashCode ^
        noticeMessage.hashCode ^
        noticeFileName.hashCode ^
        hodCollegeID.hashCode ^
        hodDepartment.hashCode;
  }
}
