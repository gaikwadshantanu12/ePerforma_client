import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/constants/static_data.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/accounts_button.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/normal_text_field.dart';

class SocialConnects extends StatefulWidget {
  const SocialConnects({super.key});

  @override
  State<SocialConnects> createState() => _SocialConnectsState();
}

class _SocialConnectsState extends State<SocialConnects> {
  final _socialLinkeController = TextEditingController();
  late String _studentCollegeID;
  String? _socialMedia;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _studentCollegeID =
        ModalRoute.of(context)?.settings.arguments as String? ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.spaceCadet,
        automaticallyImplyLeading: true,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: AppColors.spaceCadet),
        title: Text(
          'Social Connect',
          style: GoogleFonts.getFont(
            'Outfit',
            color: AppColors.isabelline,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
        elevation: 2,
      ),
      body: SafeArea(
          top: true,
          bottom: true,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  SizedBox(
                    height: deviceHeight * 0.01,
                  ),
                  Container(
                    width: deviceWidth * 0.5,
                    height: deviceHeight * 0.35,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset(
                      'assets/images/social-media.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text(
                    'Let other people connect with you !!',
                    style: GoogleFonts.getFont(
                      'Readex Pro',
                      textStyle: TextStyle(
                        fontSize: deviceWidth * 0.04,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: deviceHeight * 0.05,
                  ),
                  DropdownButtonFormField(
                    items: StaticData.socialLinks,
                    value: _socialMedia,
                    onChanged: (String? value) {
                      setState(() {
                        _socialMedia = value!;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Please select media type";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      labelText: "Select Social Type",
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
                  SizedBox(
                    height: deviceHeight * 0.02,
                  ),
                  NormalTextField(
                    controller: _socialLinkeController,
                    labelText: "Enter Link",
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Enter link !';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _socialLinkeController.text = value!;
                      _socialLinkeController.selection =
                          TextSelection.collapsed(
                              offset: _socialLinkeController.text.length);
                    },
                  ),
                  SizedBox(
                    height: deviceHeight * 0.05,
                  ),
                  AccountButton(
                    buttonText: "Add/Update Link",
                    buttonIcon: const Icon(Icons.link),
                    buttonClicked: () {},
                  )
                ],
              ),
            ),
          )),
    );
  }
}
