import 'package:flutter/material.dart';
import 'package:flutter_erp/app/data/widgets/global_widgets/erp_settings_scaffold.dart';
import 'package:flutter_erp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetResponsiveView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);
  @override
  Widget builder() {
    return ErpSettingsScaffold(
      screen: screen,
      path: Routes.PROFILE,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Connected Apps",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 1,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Superchange your",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: Colors.grey.shade700,
              letterSpacing: 0.1,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
