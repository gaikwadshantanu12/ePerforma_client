import 'package:flutter/material.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/screens/hod/access_student_documents.dart';
import 'package:student_performance_monitoring_app/screens/hod/all_students.dart';
import 'package:student_performance_monitoring_app/screens/hod/all_teachers.dart';
import 'package:student_performance_monitoring_app/screens/hod/allotment.dart';
import 'package:student_performance_monitoring_app/screens/hod/ct_allotment.dart';
import 'package:student_performance_monitoring_app/screens/hod/hod_authentication_page.dart';
import 'package:student_performance_monitoring_app/screens/hod/hod_dashboard.dart';
import 'package:student_performance_monitoring_app/screens/hod/hod_profile.dart';
import 'package:student_performance_monitoring_app/screens/hod/mentor_allotment.dart';
import 'package:student_performance_monitoring_app/screens/hod/new_notice.dart';
import 'package:student_performance_monitoring_app/screens/hod/official_notices.dart';
import 'package:student_performance_monitoring_app/screens/hod/st_allotment.dart';
import 'package:student_performance_monitoring_app/screens/hod/view_ct.dart';
import 'package:student_performance_monitoring_app/screens/hod/view_department_lecture_attendance.dart';
import 'package:student_performance_monitoring_app/screens/hod/view_mt.dart';
import 'package:student_performance_monitoring_app/screens/hod/view_st.dart';
import 'package:student_performance_monitoring_app/screens/role_selected_screen.dart';
import 'package:student_performance_monitoring_app/screens/splash_screen.dart';
import 'package:student_performance_monitoring_app/screens/students/edit_profile.dart';
import 'package:student_performance_monitoring_app/screens/students/social_connect.dart';
import 'package:student_performance_monitoring_app/screens/students/student_academics.dart';
import 'package:student_performance_monitoring_app/screens/students/student_authentication_page.dart';
import 'package:student_performance_monitoring_app/screens/students/student_dashboard.dart';
import 'package:student_performance_monitoring_app/screens/students/student_profile.dart';
import 'package:student_performance_monitoring_app/screens/students/upload_documents.dart';
import 'package:student_performance_monitoring_app/screens/students/useful_links.dart';
import 'package:student_performance_monitoring_app/screens/students/view_documents.dart';
import 'package:student_performance_monitoring_app/screens/students/view_official_notices.dart';
import 'package:student_performance_monitoring_app/screens/teachers/broadcast_message.dart';
import 'package:student_performance_monitoring_app/screens/teachers/class_teacher_view_attendance.dart';
import 'package:student_performance_monitoring_app/screens/teachers/class_teacher_view_students.dart';
import 'package:student_performance_monitoring_app/screens/teachers/lecture_attendance.dart';
import 'package:student_performance_monitoring_app/screens/teachers/mentor_meeting.dart';
import 'package:student_performance_monitoring_app/screens/teachers/teacher_authentication_page.dart';
import 'package:student_performance_monitoring_app/screens/teachers/teacher_dashboard.dart';
import 'package:student_performance_monitoring_app/screens/teachers/teacher_profile.dart';
import 'package:student_performance_monitoring_app/screens/teachers/view_batch_students.dart';
import 'package:student_performance_monitoring_app/screens/teachers/view_lecture_attendance.dart';
import 'package:student_performance_monitoring_app/screens/teachers/view_official_notices.dart';
import 'package:student_performance_monitoring_app/screens/welcome_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Performance and Monitoring App',
      theme: ThemeData(primaryColor: AppColors.spaceCadet),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/welcome_screen': (context) => const WelcomeScreen(),
        '/role_selector_page': (context) => const RoleSelectedPage(),
        '/student_authentication_page': (context) =>
            const StudentAuthenticationPage(),
        '/teacher_authentication_page': (context) =>
            const TeacherAuthenticationPage(),
        '/hod_authentication_page': (context) => const HodAuthenticationPage(),
        '/hod/hod_dashboard_page': (context) => const HodDashboardPage(),
        '/hod/official_notices_page': (context) => const OfficialNotices(),
        '/hod/new_notice_page': (context) => const NewNoticePage(),
        '/hod/all_students_page': (context) => const AllStudentsPage(),
        '/hod/all_teachers_page': (context) => const AllTeachersPage(),
        '/hod/hod_profile_page': (context) => const HodProfilePage(),
        '/hod/allotment_page': (context) => const AllotmentPage(),
        '/hod/allotment_page/ct_allotment_page': (context) =>
            const CTAllotmentPage(),
        '/hod/allotment_page/st_allotment_page': (context) =>
            const STAllotmentPage(),
        '/hod/allotment_page/view_ct_allotment_page': (context) =>
            const ViewAllCT(),
        '/hod/allotment_page/view_st_allotment_page': (context) =>
            const ViewAllST(),
        '/hod/allotment_page/mentor_allotment_page': (context) =>
            const MentorAllotment(),
        '/hod/allotment_page/view_mt_allotment_page': (context) =>
            const ViewMT(),
        '/hod/access_student_documents': (context) =>
            const AccessStudentDocuments(),
        '/hod/view_department_attendance': (context) =>
            const ViewDepartmentLectureAttendance(),
        '/teacher/teacher_dashboard_page': (context) =>
            const TeacherDashboardPage(),
        '/teacher/teacher_profile_page': (context) =>
            const TeacherProfilePage(),
        '/teacher/lecture_attendance': (context) => const LectureAttendance(),
        '/teacher/view_lecture_attendance': (context) =>
            const ViewLectureAttendance(),
        '/teacher/view_official_notices': (context) =>
            const ViewOfficialNotices(),
        '/teacher/mentor_meeting': (context) => const MentorMeeting(),
        '/teacher/class_teacher_view_class_attendance': (context) =>
            const ClassTeacherViewAttendance(),
        '/teacher/class_teacher_view_class_students': (context) =>
            const ClassTeacherViewStudents(),
        '/teacher/view_batch_students': (context) => const ViewBatchStudents(),
        '/teacher/broadcast_message': (context) => const BroadcastMessages(),
        '/student/student_dashboard_page': (context) =>
            const StudentDashboard(),
        '/student/student_useful_links': (context) => UsefullLinks(),
        '/student/student_profile_page': (context) =>
            const StudentProfilePage(),
        '/student/student_academics_page': (context) =>
            const StudentAcademicsPage(),
        '/student/edit_profile_page': (context) => const EditProfile(),
        '/student/view_notices_page': (context) => const ViewNotices(),
        '/student/upload_documents': (context) => const UploadDocuments(),
        '/student/view_documents': (context) => const ViewUploadedDocuments(),
        '/student/social_connect': (context) => const SocialConnects(),
      },
    );
  }
}
