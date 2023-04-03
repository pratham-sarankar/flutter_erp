import 'package:flutter/material.dart';
import 'package:flutter_erp/app/modules/qr_code/controllers/qr_enquiry_controller.dart';
import 'package:flutter_erp/widgets/form_field_widgets/erp_text_form_field.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class QrEnquiryView extends GetResponsiveView<QrEnquiryController> {
  QrEnquiryView({Key? key}) : super(key: key);

  @override
  Widget builder() {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 10,
          shadowColor: Colors.grey.shade200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: Get.width *
                  (screen.isPhone
                      ? 0.9
                      : screen.isDesktop
                          ? 0.4
                          : 0.6),
            ),
            padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.05,
              horizontal: Get.width * 0.02,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Hi! Good Morning",
                  style: GoogleFonts.poppins(
                    fontSize: Get.height * 0.025,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "Enter your details to enquire about the \nservices and fees",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: Get.height * 0.018,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 20),
                Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      ErpTextFormField(
                        title: "Your Name",
                        // initialValue: controller.customer.phoneNumber,
                        isRequired: true,
                        onSaved: (value) {
                          // controller.customer.phoneNumber =
                          //     (value?.isEmpty ?? true) ? null : value;
                        },
                      ),
                      ErpTextFormField(
                        title: "Phone number",
                        // initialValue: controller.customer.phoneNumber,
                        isRequired: true,
                        onSaved: (value) {
                          // controller.customer.phoneNumber =
                          //     (value?.isEmpty ?? true) ? null : value;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
