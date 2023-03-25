import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ToastService extends GetxService {
  Future<ToastService> init() async {
    return this;
  }

  void showErrorToast(String message) {
    Get.showSnackbar(
      GetSnackBar(
        messageText: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Error',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                height: 1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              message,
              style: GoogleFonts.poppins(
                  color: Colors.black, fontSize: 13, height: 1),
            ),
          ],
        ),
        snackPosition: SnackPosition.TOP,
        snackStyle: SnackStyle.FLOATING,
        maxWidth: 300,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        margin: const EdgeInsets.only(top: 10),
        backgroundColor: Colors.white,
        borderColor: Colors.black,
        borderRadius: 8,
        mainButton: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.close, color: Colors.black, size: 18),
        ),
      ),
    );
  }
}
