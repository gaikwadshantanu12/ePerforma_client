import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:student_performance_monitoring_app/constants/colors.dart';
import 'package:student_performance_monitoring_app/constants/widgets/general/single_card_item.dart';

class AllotmentPage extends StatelessWidget {
  const AllotmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String department =
        ModalRoute.of(context)!.settings.arguments as String;
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.spaceCadet,
        automaticallyImplyLeading: true,
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: AppColors.spaceCadet),
        title: Text(
          'Allotment Panel',
          style: GoogleFonts.getFont(
            'Outfit',
            color: AppColors.isabelline,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
                          context, '/hod/allotment_page/ct_allotment_page',
                          arguments: department),
                      child: SingleCardItem(
                        cardText: "CT Allotment",
                        cardImage:
                            'https://imgs.search.brave.com/Y-ea-LeVAUkYbp19-vI8l3rLxQCTnmL_GXdkYnTJJr8/rs:fit:860:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzAxLzc2Lzg0LzM5/LzM2MF9GXzE3Njg0/MzkxOV96YzlocXFj/Y0hPRGpoTFhTellv/RHI0S1gzTkRPS3hD/OS5qcGc',
                        width: width,
                        height: height,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(
                          context, '/hod/allotment_page/st_allotment_page',
                          arguments: department),
                      child: SingleCardItem(
                        cardText: "ST Allotment",
                        cardImage:
                            'https://imgs.search.brave.com/Y-ea-LeVAUkYbp19-vI8l3rLxQCTnmL_GXdkYnTJJr8/rs:fit:860:0:0/g:ce/aHR0cHM6Ly90NC5m/dGNkbi5uZXQvanBn/LzAxLzc2Lzg0LzM5/LzM2MF9GXzE3Njg0/MzkxOV96YzlocXFj/Y0hPRGpoTFhTellv/RHI0S1gzTkRPS3hD/OS5qcGc',
                        width: width,
                        height: height,
                      ),
                    ),
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
                          context, '/hod/allotment_page/view_ct_allotment_page',
                          arguments: department),
                      child: SingleCardItem(
                        cardText: "View CT",
                        cardImage:
                            'https://imgs.search.brave.com/k4Yd5-vCG168UeATzI-aPjq3wWCs6lxaDfmd34q3jWs/rs:fit:860:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzAzLzIwLzkxLzYy/LzM2MF9GXzMyMDkx/NjI5NF9jdjRzampQ/U0JlZ0FoMXltNU5X/bzdoSTMxaEM1dDNs/TC5qcGc',
                        width: width,
                        height: height,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(
                          context, '/hod/allotment_page/view_st_allotment_page',
                          arguments: department),
                      child: SingleCardItem(
                        cardText: "View ST",
                        cardImage:
                            'https://imgs.search.brave.com/k4Yd5-vCG168UeATzI-aPjq3wWCs6lxaDfmd34q3jWs/rs:fit:860:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzAzLzIwLzkxLzYy/LzM2MF9GXzMyMDkx/NjI5NF9jdjRzampQ/U0JlZ0FoMXltNU5X/bzdoSTMxaEM1dDNs/TC5qcGc',
                        width: width,
                        height: height,
                      ),
                    ),
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
                          context, '/hod/allotment_page/mentor_allotment_page',
                          arguments: department),
                      child: SingleCardItem(
                        cardText: "Mentor Allotment",
                        cardImage:
                            'https://imgs.search.brave.com/k4Yd5-vCG168UeATzI-aPjq3wWCs6lxaDfmd34q3jWs/rs:fit:860:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzAzLzIwLzkxLzYy/LzM2MF9GXzMyMDkx/NjI5NF9jdjRzampQ/U0JlZ0FoMXltNU5X/bzdoSTMxaEM1dDNs/TC5qcGc',
                        width: width,
                        height: height,
                      ),
                    ),
                    InkWell(
                      onTap: () => Navigator.pushNamed(
                          context, '/hod/allotment_page/view_mt_allotment_page',
                          arguments: department),
                      child: SingleCardItem(
                        cardText: "View MT",
                        cardImage:
                            'https://imgs.search.brave.com/k4Yd5-vCG168UeATzI-aPjq3wWCs6lxaDfmd34q3jWs/rs:fit:860:0:0/g:ce/aHR0cHM6Ly90My5m/dGNkbi5uZXQvanBn/LzAzLzIwLzkxLzYy/LzM2MF9GXzMyMDkx/NjI5NF9jdjRzampQ/U0JlZ0FoMXltNU5X/bzdoSTMxaEM1dDNs/TC5qcGc',
                        width: width,
                        height: height,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
