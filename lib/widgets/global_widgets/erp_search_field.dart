import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ErpSearchField extends StatelessWidget {
  const ErpSearchField({super.key, required this.onUpdate});

  final Function(String) onUpdate;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: SearchFieldController(),
      builder: (controller) {
        return ConstrainedBox(
          constraints: const BoxConstraints(
            minWidth: 100,
            maxWidth: 200,
          ),
          child: CupertinoSearchTextField(
            style: GoogleFonts.poppins(
              fontSize: 15,
            ),
            onChanged: (value) {
              onUpdate(value);
            },
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: context.theme.dividerTheme.color ?? Colors.grey.shade300,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            placeholderStyle: GoogleFonts.poppins(
              fontSize: 15,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w400,
            ),
            prefixIcon: const Icon(CupertinoIcons.search, size: 18),
            prefixInsets: const EdgeInsets.only(left: 10, right: 0),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          ),
        );
      },
    );
  }
}

class SearchFieldController extends GetxController {
  SearchFieldController();

  @override
  onInit() {
    super.onInit();
  }
}
