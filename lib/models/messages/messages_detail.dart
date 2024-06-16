import 'dart:convert';

class MessagesDetails {
  String teacherID;
  String message;
  String date;
  String time;

  MessagesDetails({
    required this.teacherID,
    required this.message,
    required this.date,
    required this.time,
  });

  MessagesDetails copyWith({
    String? teacherID,
    String? message,
    String? date,
    String? time,
  }) {
    return MessagesDetails(
      teacherID: teacherID ?? this.teacherID,
      message: message ?? this.message,
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'teacherID': teacherID,
      'message': message,
      'date': date,
      'time': time,
    };
  }

  factory MessagesDetails.fromMap(Map<String, dynamic> map) {
    return MessagesDetails(
      teacherID: map['teacherID'] ?? '',
      message: map['message'] ?? '',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MessagesDetails.fromJson(String source) =>
      MessagesDetails.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MessagesDetails(teacherID: $teacherID, message: $message, date: $date, time: $time)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MessagesDetails &&
        other.teacherID == teacherID &&
        other.message == message &&
        other.date == date &&
        other.time == time;
  }

  @override
  int get hashCode {
    return teacherID.hashCode ^
        message.hashCode ^
        date.hashCode ^
        time.hashCode;
  }
}
