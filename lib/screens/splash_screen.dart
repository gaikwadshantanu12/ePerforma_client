import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
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
    bool isLoggedIn = await SessionManager.isLoggedIn();
    String routeName =
        isLoggedIn ? '/student_dashboard_page' : '/welcome_screen';

    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacementNamed(routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
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
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Lottie.asset(
                  'assets/lottie_animations/animation_lnodhg8r.json',
                  width: 300,
                  height: 250,
                  fit: BoxFit.cover,
                  animate: true,
                ),
                Text(
                  'Please wait !!!\nUntill the app loads completely !!',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.getFont(
                    'Readex Pro',
                    fontSize: 20,
                    textStyle: const TextStyle(
                      color: AppColors.spaceCadet,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
