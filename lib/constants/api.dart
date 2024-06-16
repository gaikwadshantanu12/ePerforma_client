class ApiRoutes {
  static const String url = 'http://192.168.228.238:8080';

  /* Student APIs */
  static const String loginStudent = '$url/student/loginStudent';
  static const String registerNewStudent = '$url/student/addNewStudent';
  static const String getParticularStudent =
      '$url/student/getParticularStudent';
  static const String updateStudent = '$url/student/updateProfile';
  static const String noticesByDepartment =
      '$url/notices/getNoticesByDepartment';
  static const String uploadDocuments = '$url/student_documents/uploadDocument';
  static const String viewStudentDocuments =
      '$url/student_documents/studentDocuments';
  static const String downloadDocument =
      '$url/student_documents/downloadDocument';

  /* Teacher APIs */
  static const String loginTeacher = '$url/teacher/loginTeacher';
  static const String registerNewTeacher = '$url/teacher/addNewTeacher';
  static const String getMyAllSubjects = '$url/teacher/getMyAllSubjects';
  static const String getStudentsAsPerSubjectYear =
      '$url/teacher/studentsByDepartmentAndYear';
  static const String noticesTeacherByDepartment =
      '$url/notices/getNoticesByDepartment';
  static const String checkTeacherAsClassTeacher =
      '$url/class/checkClassTeacher';
  static const String checkTeacherAsBatchMentor =
      '$url/batch_allotment/checkBatchMentor';
  static const String fetchClassByTeacherID =
      '$url/class/fetchClassByTeacherID';
  static const String fetchBatchByTeacherID =
      '$url/batch_allotment/fetchBatchByTeacherID';
  static const String fetchStudentsByDeptYearAndSection =
      '$url/teacher/fetchStudentsByDeptYearAndSection';
  static const String fetchStudentsByBatch = '$url/teacher/fetchBatchStudents';
  static const String sendMessage = '$url/messages/sendMessage';
  static const String getMessages = '$url/messages/getMessages';

  /* Lecture Attendance APIs */
  static const String pushAttendance = '$url/lectureAttendance/pushAttendance';
  static const String getAttendance = '$url/lectureAttendance/getAttendance';

  /* HOD APIs */
  static const String loginHod = '$url/hod/loginHod';
  static const String deptYearAndSectionWiseStudents =
      '$url/hod/studentsByDepartmentYearAndSection';
  static const String depatWiseTeachers = '$url/hod/teachersByDepartment';
  static const String addNewNotice = '$url/notices/addNewNotice';
  static const String getNoticesOfParticularHOD = '$url/notices/hodWiseNotices';
  static const String downloadFile = '$url/notices/downloadNotice';
  static const String deleteNotice = '$url/notices/deleteNotice';
  static const String createClass = '$url/class/createClass';
  static const String viewClasses = '$url/class/viewClass';
  static const String deleteClass = '$url/class/deleteClass';
  static const String createSubject = '$url/subject/createSubject';
  static const String viewSubjects = '$url/subject/viewSubjects';
  static const String viewSubjectsByYearAndDepartment =
      '$url/subject/viewSubjectsByYearAndDepartment';
  static const String createBatch = '$url/batch_allotment/createBatch';
  static const String viewBatches = '$url/batch_allotment/viewBatches';
  static const String deleteBatch = '$url/batch_allotment/deleteBatch';
}
