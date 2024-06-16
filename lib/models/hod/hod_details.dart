import 'dart:convert';

class HodDetailsModel {
  String hodCollegeID;
  String hodName;
  String hodEmail;
  String hodPassword;
  String hodDepartment;
  String hodMobileNumber;

  HodDetailsModel({
    required this.hodCollegeID,
    required this.hodName,
    required this.hodEmail,
    required this.hodPassword,
    required this.hodDepartment,
    required this.hodMobileNumber,
  });

  HodDetailsModel copyWith({
    String? hodCollegeID,
    String? hodName,
    String? hodEmail,
    String? hodPassword,
    String? hodDepartment,
    String? hodMobileNumber,
  }) {
    return HodDetailsModel(
      hodCollegeID: hodCollegeID ?? this.hodCollegeID,
      hodName: hodName ?? this.hodName,
      hodEmail: hodEmail ?? this.hodEmail,
      hodPassword: hodPassword ?? this.hodPassword,
      hodDepartment: hodDepartment ?? this.hodDepartment,
      hodMobileNumber: hodMobileNumber ?? this.hodMobileNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hodCollegeID': hodCollegeID,
      'hodName': hodName,
      'hodEmail': hodEmail,
      'hodPassword': hodPassword,
      'hodDepartment': hodDepartment,
      'hodMobileNumber': hodMobileNumber,
    };
  }

  factory HodDetailsModel.fromMap(Map<String, dynamic> map) {
    return HodDetailsModel(
      hodCollegeID: map['hodCollegeID'] ?? '',
      hodName: map['hodName'] ?? '',
      hodEmail: map['hodEmail'] ?? '',
      hodPassword: map['hodPassword'] ?? '',
      hodDepartment: map['hodDepartment'] ?? '',
      hodMobileNumber: map['hodMobileNumber'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory HodDetailsModel.fromJson(String source) =>
      HodDetailsModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'HodDetailsModel(hodCollegeID: $hodCollegeID, hodName: $hodName, hodEmail: $hodEmail, hodPassword: $hodPassword, hodDepartment: $hodDepartment, hodMobileNumber: $hodMobileNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is HodDetailsModel &&
        other.hodCollegeID == hodCollegeID &&
        other.hodName == hodName &&
        other.hodEmail == hodEmail &&
        other.hodPassword == hodPassword &&
        other.hodDepartment == hodDepartment &&
        other.hodMobileNumber == hodMobileNumber;
  }

  @override
  int get hashCode {
    return hodCollegeID.hashCode ^
        hodName.hashCode ^
        hodEmail.hashCode ^
        hodPassword.hashCode ^
        hodDepartment.hashCode ^
        hodMobileNumber.hashCode;
  }
}
