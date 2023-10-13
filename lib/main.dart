import 'package:flutter/material.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/screens/role_selected_screen.dart';
import 'package:student_performance_monitoring_app/screens/splash_screen.dart';
import 'package:student_performance_monitoring_app/screens/students/student_authentication_page.dart';
import 'package:student_performance_monitoring_app/screens/students/student_dashboard.dart';
import 'package:student_performance_monitoring_app/screens/students/useful_links.dart';
import 'package:student_performance_monitoring_app/screens/teachers/teacher_authentication_page.dart';
import 'package:student_performance_monitoring_app/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
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
        '/student_dashboard_page': (context) => const StudentDashboard(),
        '/student_useful_links': (context) => UsefullLinks()
      },
    );
  }
}
