import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/session_manager.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/single_card_item.dart';
import 'package:student_performance_monitoring_app/models/hod/hod_details.dart';

import '../../constants/colors.dart';

class HodDashboardPage extends StatelessWidget {
  const HodDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HodDetailsModel hod =
        ModalRoute.of(context)!.settings.arguments as HodDetailsModel;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      appBar: AppBar(
        backgroundColor: AppColors.spaceCadet,
        automaticallyImplyLeading: false,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: AppColors.spaceCadet),
        title: Text(
          'HOD\'s Dashboard',
          style: GoogleFonts.getFont(
            'Outfit',
            color: AppColors.isabelline,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
        elevation: 2,
        actions: [
          Align(
            alignment: const AlignmentDirectional(0, 0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
              child: IconButton(
                icon: const Icon(
                  Icons.logout,
                  size: 24,
                  color: AppColors.isabelline,
                ),
                onPressed: () {
                  SessionManager.setGlobalAppRole('');
                  SessionManager.logoutHod();
                  Navigator.pushReplacementNamed(context, '/welcome_screen');
                },
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        top: true,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: const AlignmentDirectional(0, -1),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pushNamed(
                          context, '/hod/hod_profile_page',
                          arguments: hod),
                      child: SingleCardItem(
                        cardText: "My Profile",
                        cardImage:
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGnMBznsXiF3d24T0m-uEgiQUkjPeutggHKw&usqp=CAU',
                        width: width,
                        height: height,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(
                          context, '/hod/official_notices_page',
                          arguments: hod),
                      child: SingleCardItem(
                        cardText: "Notices",
                        cardImage:
                            'https://imgs.search.brave.com/CPkXOYx-r4OM-S3v5oj3wOf2hJ6R3-iHSLT7WpU3wSc/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/ZnJlZS1waG90by8z/ZC1yZW5kZXItbWVn/YXBob25lLWxvdWRz/cGVha2VyLXdpdGgt/Zmxhc2hlc18xMDc3/OTEtMTczNDUuanBn',
                        width: width,
                        height: height,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, '/hod/all_students_page',
                            arguments: hod),
                        child: SingleCardItem(
                          cardText: 'Students',
                          cardImage:
                              'https://imgs.search.brave.com/kTchEAZz9dmmQUoaA0VQo3MDfm-Gcot-gzzwmkbpWnM/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9zbWFs/bGltZy5wbmdrZXku/Y29tL3BuZy9zbWFs/bC80MDAtNDAwMzY4/MF9yZWdpc3RyYXRp/b24tZm9yLXVuZGVy/LWdyYWR1YXRlLXN0/dWRlbnQtaWNvbi1w/bmcucG5n',
                          width: width,
                          height: height,
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, '/hod/all_teachers_page',
                            arguments: hod.hodDepartment),
                        child: SingleCardItem(
                          cardText: 'Teachers',
                          cardImage:
                              'https://imgs.search.brave.com/usV2CrKcNR5R9_gg77nynKZsW3yWbCyI5a_SiwvrIw0/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9pbWFn/ZXMudW5zcGxhc2gu/Y29tL3Bob3RvLTE1/NzM0OTY3OTk2NTIt/NDA4YzJhYzlmZTk4/P2l4bGliPXJiLTQu/MC4zJml4aWQ9TTN3/eE1qQTNmREI4TUh4/elpXRnlZMmg4TVRa/OGZIUmxZV05vWlhK/OFpXNThNSHg4TUh4/OGZEQT0mdz0xMDAw/JnE9ODA',
                          width: width,
                          height: height,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0, -1),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, '/hod/allotment_page',
                            arguments: hod.hodDepartment),
                        child: SingleCardItem(
                          cardText: ' Allotment',
                          cardImage:
                              'https://imgs.search.brave.com/PhXozcg6v3WOLxddxgYBC41s6-1ddCftFmuzGm8YQDA/rs:fit:860:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzAyLzA5Lzg0LzYz/LzM2MF9GXzIwOTg0/NjMxOF9OQVFtV2hp/ZVB6RUJWeUlTUzVF/YnJIZ0t0SE54Vm0z/aS5qcGc',
                          width: width,
                          height: height,
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.pushNamed(
                          context,
                          '/hod/view_department_attendance',
                          arguments: hod.hodDepartment,
                        ),
                        child: SingleCardItem(
                          cardText: 'Attendance',
                          cardImage:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSY79XARUFPkF5NpJUkQfoREI-hrvRODWD24g&usqp=CAU',
                          width: width,
                          height: height,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
