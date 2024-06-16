// import 'package:go_router/go_router.dart';
// import 'package:student_performance_monitoring_app/models/teacher/teacher_details.dart';
// import 'package:student_performance_monitoring_app/screens/hod/all_students.dart';
// import 'package:student_performance_monitoring_app/screens/hod/all_teachers.dart';
// import 'package:student_performance_monitoring_app/screens/hod/allotment.dart';
// import 'package:student_performance_monitoring_app/screens/hod/ct_allotment.dart';
// import 'package:student_performance_monitoring_app/screens/hod/hod_authentication_page.dart';
// import 'package:student_performance_monitoring_app/screens/hod/hod_dashboard.dart';
// import 'package:student_performance_monitoring_app/screens/hod/hod_profile.dart';
// import 'package:student_performance_monitoring_app/screens/hod/new_notice.dart';
// import 'package:student_performance_monitoring_app/screens/hod/official_notices.dart';
// import 'package:student_performance_monitoring_app/screens/hod/st_allotment.dart';
// import 'package:student_performance_monitoring_app/screens/hod/view_ct.dart';
// import 'package:student_performance_monitoring_app/screens/hod/view_st.dart';
// import 'package:student_performance_monitoring_app/screens/role_selected_screen.dart';
// import 'package:student_performance_monitoring_app/screens/splash_screen.dart';
// import 'package:student_performance_monitoring_app/screens/students/edit_profile.dart';
// import 'package:student_performance_monitoring_app/screens/students/student_academics.dart';
// import 'package:student_performance_monitoring_app/screens/students/student_authentication_page.dart';
// import 'package:student_performance_monitoring_app/screens/students/student_dashboard.dart';
// import 'package:student_performance_monitoring_app/screens/students/student_profile.dart';
// import 'package:student_performance_monitoring_app/screens/students/useful_links.dart';
// import 'package:student_performance_monitoring_app/screens/teachers/lecture_attendance.dart';
// import 'package:student_performance_monitoring_app/screens/teachers/teacher_authentication_page.dart';
// import 'package:student_performance_monitoring_app/screens/teachers/teacher_dashboard.dart';
// import 'package:student_performance_monitoring_app/screens/teachers/teacher_profile.dart';
// import 'package:student_performance_monitoring_app/screens/welcome_screen.dart';

// final router = GoRouter(
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (context, state) => const SplashScreen(),
//     ),
//     GoRoute(
//       path: '/welcome_screen',
//       builder: (context, state) => const WelcomeScreen(),
//     ),
//     GoRoute(
//       path: '/role_selector_page',
//       builder: (context, state) => const RoleSelectedPage(),
//     ),
//     GoRoute(
//       path: '/student_authentication_page',
//       builder: (context, state) => const StudentAuthenticationPage(),
//     ),
//     GoRoute(
//       path: '/teacher_authentication_page',
//       builder: (context, state) => const TeacherAuthenticationPage(),
//     ),
//     GoRoute(
//       path: '/hod_authentication_page',
//       builder: (context, state) => const HodAuthenticationPage(),
//     ),
//     GoRoute(
//       path: '/hod/hod_dashboard_page',
//       builder: (context, state) => const HodDashboardPage(),
//     ),
//     GoRoute(
//       path: '/hod/official_notices_page',
//       builder: (context, state) => const OfficialNotices(),
//     ),
//     GoRoute(
//       path: '/hod/new_notice_page',
//       builder: (context, state) => const NewNoticePage(),
//     ),
//     GoRoute(
//       path: '/hod/all_students_page',
//       builder: (context, state) => const AllStudentsPage(),
//     ),
//     GoRoute(
//       path: '/hod/all_teachers_page',
//       builder: (context, state) => const AllTeachersPage(),
//     ),
//     GoRoute(
//       path: '/hod/hod_profile_page',
//       builder: (context, state) => const HodProfilePage(),
//     ),
//     GoRoute(
//       path: '/hod/allotment_page',
//       builder: (context, state) => const AllotmentPage(),
//     ),
//     GoRoute(
//       path: '/hod/allotment_page/ct_allotment_page',
//       builder: (context, state) => const CTAllotmentPage(),
//     ),
//     GoRoute(
//       path: '/hod/allotment_page/st_allotment_page',
//       builder: (context, state) => const STAllotmentPage(),
//     ),
//     GoRoute(
//       path: '/hod/allotment_page/view_ct_allotment_page',
//       builder: (context, state) => const ViewAllCT(),
//     ),
//     GoRoute(
//       path: '/hod/allotment_page/view_st_allotment_page',
//       builder: (context, state) => const ViewAllST(),
//     ),
//     GoRoute(
//       path: '/teacher/teacher_dashboard_page',
//       name: 'teacherDashboard',
//       builder: (context, state) => const TeacherDashboardPage(),
//     ),
//     GoRoute(
//       path: '/teacher/teacher_profile_page',
//       builder: (context, state) => const TeacherProfilePage(),
//     ),
//     GoRoute(
//       path: '/teacher/lecture_attendance',
//       builder: (context, state) => const LectureAttendance(),
//     ),
//     GoRoute(
//       path: '/student/student_dashboard_page',
//       builder: (context, state) => const StudentDashboard(),
//     ),
//     GoRoute(
//       path: '/student/student_useful_links',
//       builder: (context, state) => UsefullLinks(),
//     ),
//     GoRoute(
//       path: '/student/student_profile_page',
//       builder: (context, state) => const StudentProfilePage(),
//     ),
//     GoRoute(
//       path: '/student/student_academics_page',
//       builder: (context, state) => const StudentAcademicsPage(),
//     ),
//     GoRoute(
//       path: '/student/edit_profile_page',
//       builder: (context, state) => const EditProfile(),
//     )
//   ],
// );
