import 'package:flutter/material.dart';
import 'package:flutter_erp/app/modules/qr_code/views/qr_enquiry_view.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/qr_code_controller.dart';

class QrCodeView extends GetView<QrCodeController> {
  const QrCodeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 10,
          shadowColor: Colors.grey.shade200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.05,
              horizontal: Get.width * 0.02,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Scan QR code",
                  style: GoogleFonts.poppins(
                    fontSize: Get.height * 0.03,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Scan this QR to enquire about the \nservices and fees",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: Get.height * 0.018,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 20),
                QrImage(
                  data: "https://admin.gyanishyogaschool.com/qr/?branch_id=2",
                  version: QrVersions.auto,
                  size: Get.height * 0.25,
                ),
                TextButton(
                  onPressed: () {
                    Get.to(QrEnquiryView());
                  },
                  child: const Text("Enquire now!"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
