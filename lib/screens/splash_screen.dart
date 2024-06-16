import 'package:flutter/material.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/default_animation.dart';
import '../constants/session_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkSessionAndNavigate();
  }

  void _checkSessionAndNavigate() async {
    final storedStudent = await SessionManager.getStoredStudent();
    final storedTeacher = await SessionManager.getStoredTeacher();
    final storedHod = await SessionManager.getStoredHod();
    String? role = await SessionManager.getGlobalAppRole();
    String routeName;

    switch (role) {
      case 'student':
        {
          routeName = storedStudent != null
              ? '/student/student_dashboard_page'
              : '/welcome_screen';
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context)
                .pushReplacementNamed(routeName, arguments: storedStudent);
          });
          // ignore: use_build_context_synchronously
          // context.go(storedStudent != null
          //     ? '/student/student_dashboard_page'
          //     : '/welcome_screen');
        }
        break;
      case 'teacher':
        {
          routeName = storedTeacher != null
              ? '/teacher/teacher_dashboard_page'
              : '/welcome_screen';
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context)
                .pushReplacementNamed(routeName, arguments: storedTeacher);
          });
          // ignore: use_build_context_synchronously
          // context.go(storedTeacher != null
          //     ? '/teacher/teacher_dashboard_page'
          //     : '/welcome_screen');
        }
        break;
      case 'hod':
        {
          routeName =
              storedHod != null ? '/hod/hod_dashboard_page' : '/welcome_screen';
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context)
                .pushReplacementNamed(routeName, arguments: storedHod);
          });
          // ignore: use_build_context_synchronously
          // context.go(storedHod != null
          //     ? '/hod/hod_dashboard_page'
          //     : '/welcome_screen');
        }
        break;
      default:
        {
          routeName = '/welcome_screen';
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.of(context).pushReplacementNamed(routeName);
          });
          // ignore: use_build_context_synchronously
          // context.go('/welcome_screen');
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        top: true,
        child: Align(
          alignment: const AlignmentDirectional(0.00, 0.00),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.primaryBackground,
            ),
            child: DefaultAnimationMessage(
              animationFile: "assets/lottie_animations/screen_loader.json",
              animationMessage:
                  "Please wait !!!\nUntill the app loads completely !!",
              deviceWidth: deviceWidth,
              deviceHeight: deviceHeight,
            ),
          ),
        ),
      ),
    );
  }
}
