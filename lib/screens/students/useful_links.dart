import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class UsefullLinks extends StatelessWidget {
  UsefullLinks({super.key});

  final List<Map<String, dynamic>> websiteLists = [
    {
      'image':
          'https://upload.wikimedia.org/wikipedia/en/e/eb/All_India_Council_for_Technical_Education_logo.png',
      'title': 'AICTE India',
      'website': 'https://www.aicte-india.org/'
    },
    {
      'image':
          'https://www.sankardevcollege.edu.in/wp-content/uploads/2019/09/naac-300x256.png',
      'title': 'NAAC India',
      'website': 'http://naac.gov.in/index.php/en/'
    },
    {
      'image':
          'https://play-lh.googleusercontent.com/B_9kuzVAMeVQT4EW2TCddgoXnzulO153Y5DdtTBuf1HFIMC_UIhq6umIYQaqgYtk0Vc',
      'title': 'MahaDBT Portal',
      'website': 'https://mahadbt.maharashtra.gov.in/login/login'
    },
    {
      'image':
          'https://play-lh.googleusercontent.com/69Liz0_qRqvT9kZCQHow1anTKwRr59EbvrLkZ9-oXETnCajZ_9UiM-BRbUv3l5RSfic=w600-h300-pc0xffffff-pd',
      'title': 'MSBTE Office',
      'website': 'https://msbte.org.in/'
    },
    {
      'image':
          'https://realestatelawjournal.in/wp-content/uploads/2023/08/Maharashtra-Government.jpg',
      'title': 'M-DTE Office',
      'website': 'https://www.dtemaharashtra.gov.in/'
    },
    {
      'image':
          'https://lh3.googleusercontent.com/ksH4JJqsMO6TFVa-_V0BhHFtxuvaFeGgFZPGh8GA0CBO4QhJYg_3B0w-OHZZTVOHIXLO',
      'title': 'Maha Cet Cell',
      'website': 'https://cetcell.mahacet.org/'
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGrmqbWDBGGrpoTGFY0YvM1svnbk6xY_LCXw&usqp=CAU',
      'title': 'SPPU Official',
      'website': 'http://www.unipune.ac.in/'
    },
    {
      'image': 'https://adfieds.com/wp-content/uploads/2019/03/logo-2.png',
      'title': 'ADYPSOE',
      'website': 'https://adypsoe.in/'
    },
    {
      'image':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSesmoiuYruCecjxdVwSoEL8bgWMKxVuxEevJFaICcsre9udBLvSql6slptXf0O38V1LMo&usqp=CAU',
      'title': 'ADYPSOE ERP',
      'website': 'https://dypsoe.dyptcmis.com/'
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.spaceCadet,
        automaticallyImplyLeading: true,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: AppColors.spaceCadet),
        title: Text(
          'Useful Links',
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
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
          child: ListView.builder(
              itemCount: websiteLists.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () async {
                    try {
                      Uri uri = Uri.parse(websiteLists[index]['website']);
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri);
                      } else {
                        print("Could not launch $uri");
                      }
                    } catch (e) {
                      throw "Exception is $e";
                    }
                  },
                  child: Container(
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height * 0.15,
                    margin: const EdgeInsetsDirectional.fromSTEB(0, 10, 0, 10),
                    decoration: BoxDecoration(
                      color: AppColors.freshWhite,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: MediaQuery.sizeOf(context).width * 0.3,
                            height: 120,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              websiteLists[index]['image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            websiteLists[index]['title'],
                            style: GoogleFonts.getFont(
                              'Readex Pro',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
