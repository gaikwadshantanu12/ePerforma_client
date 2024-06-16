import 'dart:convert';

class StudentDocumentDetails {
  String studentCollegeID;
  String documentName;
  String documentType;

  StudentDocumentDetails({
    required this.studentCollegeID,
    required this.documentName,
    required this.documentType,
  });

  StudentDocumentDetails copyWith({
    String? studentCollegeID,
    String? documentName,
    String? documentType,
  }) {
    return StudentDocumentDetails(
      studentCollegeID: studentCollegeID ?? this.studentCollegeID,
      documentName: documentName ?? this.documentName,
      documentType: documentType ?? this.documentType,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'studentCollegeID': studentCollegeID,
      'documentName': documentName,
      'documentType': documentType,
    };
  }

  factory StudentDocumentDetails.fromMap(Map<String, dynamic> map) {
    return StudentDocumentDetails(
      studentCollegeID: map['studentCollegeID'] ?? '',
      documentName: map['documentName'] ?? '',
      documentType: map['documentType'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory StudentDocumentDetails.fromJson(String source) =>
      StudentDocumentDetails.fromMap(json.decode(source));

  @override
  String toString() =>
      'StudentDocumentDetails(studentCollegeID: $studentCollegeID, documentName: $documentName, documentType: $documentType)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is StudentDocumentDetails &&
        other.studentCollegeID == studentCollegeID &&
        other.documentName == documentName &&
        other.documentType == documentType;
  }

  @override
  int get hashCode =>
      studentCollegeID.hashCode ^ documentName.hashCode ^ documentType.hashCode;
}
