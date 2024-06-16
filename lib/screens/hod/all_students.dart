import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/constants/static_data.dart';
import 'package:student_performance_monitoring_app/constants/widgets/hod/students_grid.dart';
import 'package:student_performance_monitoring_app/models/hod/hod_details.dart';

class AllStudentsPage extends StatefulWidget {
  const AllStudentsPage({super.key});

  @override
  State<AllStudentsPage> createState() => _AllStudentsPageState();
}

class _AllStudentsPageState extends State<AllStudentsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late PageController _pageController;
  String? _studentCurrentSection;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _pageController = PageController(initialPage: 0);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  void _handleTabSelection() {
    _pageController.animateToPage(
      _tabController.index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
    _pageController.jumpToPage(_tabController.index);
  }

  @override
  Widget build(BuildContext context) {
    final HodDetailsModel hod =
        ModalRoute.of(context)!.settings.arguments as HodDetailsModel;

    return WillPopScope(
      onWillPop: () async {
        if (_tabController.index != 0) {
          _tabController.animateTo(0); // Navigate to first tab
          return false; // Prevent default back button action
        } else {
          return true; // Allow default back button behavior
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.spaceCadet,
          automaticallyImplyLeading: true,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: AppColors.spaceCadet),
          title: Text(
            'All Students',
            style: GoogleFonts.getFont(
              'Outfit',
              color: AppColors.isabelline,
              fontSize: 22,
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                text: 'SE',
              ),
              Tab(
                text: 'TE',
              ),
              Tab(
                text: 'BE',
              ),
            ],
            unselectedLabelColor: AppColors.heliotropeGray,
            indicatorColor: AppColors.spaceCadet,
            indicatorWeight: 2,
          ),
          centerTitle: false,
          elevation: 2,
        ),
        body: PageView(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          onPageChanged: (index) {
            _tabController.animateTo(index);
          },
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 10, 8, 10),
                  child: DropdownButtonFormField(
                    items: StaticData.sections,
                    value: _studentCurrentSection,
                    onChanged: (String? value) {
                      setState(() {
                        _studentCurrentSection = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Please select section";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Select Section",
                      labelStyle: GoogleFonts.getFont(
                        'Readex Pro',
                        textStyle: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 16,
                        ),
                      ),
                      hintStyle: GoogleFonts.getFont(
                        'Readex Pro',
                        textStyle: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 16,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.secondaryText,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.secondaryText,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.lightRed,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.lightRed,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                _studentCurrentSection != null
                    ? StudentsGrid(
                        year: "SE",
                        department: hod.hodDepartment,
                        section: _studentCurrentSection!,
                      )
                    : Container(),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 10, 8, 10),
                  child: DropdownButtonFormField(
                    items: StaticData.sections,
                    value: _studentCurrentSection,
                    onChanged: (String? value) {
                      setState(() {
                        _studentCurrentSection = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Please select section";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Select Section",
                      labelStyle: GoogleFonts.getFont(
                        'Readex Pro',
                        textStyle: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 16,
                        ),
                      ),
                      hintStyle: GoogleFonts.getFont(
                        'Readex Pro',
                        textStyle: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 16,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.secondaryText,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.secondaryText,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.lightRed,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.lightRed,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                _studentCurrentSection != null
                    ? StudentsGrid(
                        year: "TE",
                        department: hod.hodDepartment,
                        section: _studentCurrentSection!,
                      )
                    : Container(),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(8, 10, 8, 10),
                  child: DropdownButtonFormField(
                    items: StaticData.sections,
                    value: _studentCurrentSection,
                    onChanged: (String? value) {
                      setState(() {
                        _studentCurrentSection = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Please select section";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Select Section",
                      labelStyle: GoogleFonts.getFont(
                        'Readex Pro',
                        textStyle: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 16,
                        ),
                      ),
                      hintStyle: GoogleFonts.getFont(
                        'Readex Pro',
                        textStyle: const TextStyle(
                          color: AppColors.secondaryText,
                          fontSize: 16,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.secondaryText,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.secondaryText,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.lightRed,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: AppColors.lightRed,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                _studentCurrentSection != null
                    ? StudentsGrid(
                        year: "BE",
                        department: hod.hodDepartment,
                        section: _studentCurrentSection!,
                      )
                    : Container(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
